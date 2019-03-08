function [] = ShowMatchedPoints(points1,points2,im1,im2)
    figure;
    [rows1,cols1] = size(im1);
    [rows2,cols2] = size(im2);

    stackedImage = zeros(max([rows1,rows2]), cols1+cols2);
    stackedImage = cast(stackedImage, class(im1));
    stackedImage(1:rows1,1:cols1) = im1;
    stackedImage(1:rows2,cols1+1:cols1+cols2) = im2;

    imshow(stackedImage);
    width = size(im1, 2);
    hold on;
    numPoints = size(points1, 1);
    for i = 1 : numPoints
        plot(points1(i, 1), points1(i, 2), 'y+', points2(i, 1) + width, points2(i, 2), 'y+');
        line([points1(i, 1) points2(i, 1) + width], [points1(i, 2) points2(i, 2)], 'Color', 'yellow');
    end
    hold off;
end