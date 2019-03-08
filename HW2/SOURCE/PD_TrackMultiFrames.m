function [A_cell]=TrackMultiFrames(template,image_cell)

close all;
A_cell=cell(4,1);
ransac_thr=3;
ransac_iter=500;

output_size=size(template);

  x11=[1;1;1];
  x12=[output_size(2);1;1];
  x13=[output_size(2);output_size(1);1];
  x14=[output_size(2);output_size(1);1];
  x21=zeros(3,1);
  x22=zeros(3,1);
  x23=zeros(3,1);
  x24=zeros(3,1);
  target=image_cell{1};
  [x1,x2]=findMatch(template,target);
  [A]=AlignImageUsingFeature(x1,x2, ransac_thr,ransac_iter);
  [A_refined]=AlignImage(rgb2gray(template),rgb2gray(target),A);
  template=WarpImage(target, A_refined,size(template));
  A_cell{1}=A_refined;
  
x21=A_refined*x11;
x22=A_refined*x12;
x23=A_refined*x13;
x24=A_refined*x14;

width=x22(1)-x21(1);
height=x24(2)-x21(2);

figure;
imshow(target);
hold on;
rectangle('Position', [x21(1) x21(2) width height], 'EdgeColor', 'r');
%template= image_cell{i};
    
  
  
  
for i=2:4
    target=image_cell{i};
%     [x1,x2]=findMatch(template,target);
%     [A]=AlignImageUsingFeature(x1,x2, ransac_thr,ransac_iter);
    

% warps the target image onto the template image
% if i==1
%   output_size=size(template);
% else
%     output_size=size(image_cell{i});
% end
  output_size=size(template);
 % [I_warped]= WarpImage(target,A,size(template));
  [A_refined]=AlignImage(rgb2gray(template),rgb2gray(target),A_cell{i-1});
  

    
%template=WarpImage(target, A_refined,size(template));
A_cell{i}=A_refined;
template=WarpImage(target, A_refined,size(template));
  



x21=A_refined*x11;
x22=A_refined*x12;
x23=A_refined*x13;
x24=A_refined*x14;

width=x22(1)-x21(1);
height=x24(2)-x21(2);

figure;
imshow(target);
hold on;
rectangle('Position', [x21(1) x21(2) width height], 'EdgeColor', 'r');

%template= image_cell{i};
    
   
    
    
    
    
    
    
    
    
    
    
end


end