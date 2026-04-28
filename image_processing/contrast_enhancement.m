%-----------------------------------% 
% Increase Grayscale Image Contrast %
%-----------------------------------% 

I = imread("darkworms.jpg");
imshow(I)

% display a histogram of the pixel intensities in an image
imhist(I);

% adjusts intensity values in a grayscale image to increase contrast
Iadj = imadjust(I);
imshow(Iadj)
imhist(darkAdj)

% imadjust() does not work as well on bright image
bright = imread("brightworms.jpg");
imshow(bright)
brightAdj= imadjust(bright);
imshow(brightAdj)
imhist(brightAdj)

% Specify contrast limits in imadjust()
brightAdj = imadjust(bright, [210/255 230/255]);
imshow(brightAdj)

%-------------------------------% 
% Increase Color Image Contrast %
%-------------------------------%
bday = imread("birthdayCake.jpeg");

bdayLight = imlocalbrighten(bday);
imshow(bdayLight)

%---------------------------------------------------% 
% Histogram Equalization to Increase Shades of Gray %
%---------------------------------------------------% 
desk = imread("desk.jpg")
deskAdj = imadjust(desk);
imshowpair(desk,deskAdj,"montage")
imhist(desk)
imhist(deskAdj)

deskEq = histeq(desk);
imshow(deskEq) 
imhist(deskEq)

%------------------------------------------% 
% Adjust Contrast in an Unevenly Lit Image %
%------------------------------------------% 
book = imread("book.jpg");
imshow(book)
imhist(book)
imshow(imadjust(book))
imshow(histeq(book))

bookAdapt = adapthisteq(book);
imshow(bookAdapt)

%-----------------------------------------------% 
% Standardize Brightness Across Multiple Images %
%-----------------------------------------------%
roundworms = imread("worms.jpg");
imshow(roundworms)
rwAdj = imadjust(roundworms);
imhist(rwAdj)

roundworms2 = imread("worms2.jpg");
imshow(roundworms2)
rw2Adj = imhistmatch(roundworms2, rwAdj);
imshow(rw2Adj)


