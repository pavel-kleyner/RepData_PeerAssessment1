function image=readImage(imgName)
%%%NEED TO FIGURE OUT IMAGE PATH
%imagePath = which(imgName);
% imagePath = ['C:', filesep(),'Users',filesep(), 'Pavel',filesep(),'Documents',filesep(),'MATLAB',filesep(),'LabProject2015_Part1',filesep(),'Player_Images', filesep()];
% %playerPath=[imagePath,imgName];
% playerImage = [imagePath, 'player', num2str(imgName), '.png'];

img_initial=imread(imgName);

if ndims(img_initial)>2
    img_initial=rgb2gray(img_initial);
end

image=im2double(img_initial);
end