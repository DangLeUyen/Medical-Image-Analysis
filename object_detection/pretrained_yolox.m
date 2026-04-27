% Pretrained YOLOX Detectors
% Read the image
im = imread("bell_pepper.png");
imshow(im)

% detect in the image using a pretrained YOLOX
detector = yoloxObjectDetector("tiny-coco");
[dbox, dscore, dlabel] = detect(detector, manU);

% visualize detections
detectedIm = insertObjectAnnotation(im,"rectangle",dbox, dlabel);
imshow(detectedIm)
