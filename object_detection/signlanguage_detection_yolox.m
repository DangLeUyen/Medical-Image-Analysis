
load /CourseData/aslVowels.mat gTruthVowels
[imds,bxds] = objectDetectorTrainingData(gTruthVowels);
gtData = combine(imds,bxds);
countEachLabel(bxds)

% Split Data into Training, Validation, and Testing Data

% shuffle the data
gtShuffled = shuffle(gtData)

% Split the data with 70% for training, 10% for validation, 20% for testing
numFiles = numpartitions(gtShuffled);
numTrain = numFiles*0.7;
numVal = numFiles*0.1;

gtTrain = subset(gtShuffled,1:numTrain);
gtVal = subset(gtShuffled, numTrain+1:numTrain+numVal);
gtTest = subset(gtShuffled, numTrain+numVal+1:numFiles);

% Data Augmentation for training
gtTrainAug = transform(gtTrain, @flipAug);

% a pretrained detector for transfer learning
classes = ["A" "E" "I" "O" "U"];
detector = yoloxObjectDetector("tiny-coco", classes, [224 224 3]);

% define training options for transfer learning
options = trainingOptions("adam", ...
    MiniBatchSize=70, ...
    MaxEpochs=10, ...
    ValidationData=gtVal, ...
    ValidationFrequency=2, ...
    Plots="training-progress");

% TRAINING
aslDetector = trainYOLOXObjectDetector(gtTrainAug, ...
    detector, ...
    options);

% TESTING
results = detect(aslDetector, gtTest);

% Calculate the Confusion Matrix
metrics = evaluateObjectDetection(results, testSet, 0.85);
[confMat, confLabels] = confusionMatrix(metrics);
confusionchart(confMat{1}, confLabels)

% Plot Precision and Recall Curves
[p, r, s] = precisionRecall(metrics);

% Plot precision versus score for the letter O 
plot(s{4}, p{4}, "o-");
xlabel("Score");
ylabel("Precision");
title("O");

% Plot recall versus score for the letter O 
plot(s{4}, r{4}, "o-");
xlabel("Score");
ylabel("Recall");
title("O");

% Plot precision versus recall 
plot(r{4}, p{4}, "o-");
xlabel("Recall");
ylabel("Precision");
title("O");


function out = flipAug(data)
    im = data{1};
    bb = data{2};
    lab = data{3};
    % Random transformation
    tform = randomAffine2d(XReflection=true);
    augmentedImage = imwarp(im, tform);
    imshow(augmentedImage)
    % calculate the spatial reference
    spatialRef = affineOutputView(size(augmentedImage), tform);
    augmentedBoxes = bboxwarp(bb, tform, spatialRef);
    
    out = {augmentedImage augmentedBoxes lab};
end
