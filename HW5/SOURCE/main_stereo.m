
im1 = imread('left.bmp');
im2 = imread('right.bmp');

K = [700/2 0 960/2;
     0 700/2 540/2;
     0 0 1];
[x1, x2] = FindMatch(im1, im2);
[F] = ComputeF(x1, x2);

% Compute four configurations of camera pose given F
[R1, C1, R2, C2, R3, C3, R4, C4] = ComputeCameraPose(F, K);

% Triangulate Points using four configurations
% e.g., P1: reference camera projection matrix at origin, P2: relative
% camera projection matrix with respect to P1
% X1 = Triangulation(P1, P2, x1, x2);

% Disambiguate camera pose
[R,C,X] = PoseDisambiguation(R1,C1,X1,R2,C2,X2,R3,C3,X3,R4,C4,X4);

% Stereo rectification
[H1, H2] = ComputeRectification(K, R, C);
im1_w = WarpImage(im1, H1);
im2_w = WarpImage(im2, H2);

im1_w = imresize(im1_w, 0.5);
im2_w = imresize(im1_w, 0.5);
[disp] = DenseMatch(im1_w, im2_w);

figure(1)
clf;
imagesc(disp);
axis equal
axis off
colormap(jet);

