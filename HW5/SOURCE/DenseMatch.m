% function [disp] = DenseMatch(im1, im2)
%     [H,W,~] = size(im1);
%     [~,d1] = vl_dsift(single(padarray(rgb2gray(im1),[1 1],0,'symmetric')),'step',1,'size',1,'Geometry',[3 3 5]);
%     [~,d2] = vl_dsift(single(padarray(rgb2gray(im2),[1 1],0,'symmetric')),'step',1,'size',1,'Geometry',[3 3 5]);
%     num_features = min(size(d1));
%     d1 = reshape(d1',[H W num_features]);
%     d2 = reshape(d2',[H W num_features]);
%     disp = zeros([H,W]);
%     for i=1:H
%         for j=1:W
%             [f,~] = knnsearch(double(reshape(d2(i,1:j,:),[],num_features)), double(reshape(d1(i,j,:),[],num_features)));
%             disp(i,j) = f-j;
%         end
%     end
% end

% function [disp] = DenseMatch(im1, im2)
% im1_new=single(rgb2gray(im1));
% im2_new=single(rgb2gray(im2));
% im1_padded=zeros(size(im1,1)+9, size(im1,2)+9);
% im2_padded=zeros(size(im1,1)+9, size(im1,2)+9);
% 
% 
% for i=1:size(im1,1)
%     for j=1:size(im1,2)
%       im1_padded(i+5,j+5)=im1_new(i,j);
%       im2_padded(i+5,j+5)=im2_new(i,j);
%     end
% end
% [f1, d1] = vl_dsift(single(im1_padded),'step',1) ;
% [f2, d2] = vl_dsift(single(im2_padded),'step',1) ;
% d1_new=reshape(d1',[size(im1,1) size(im1,2),128]);
% d2_new=reshape(d2',[size(im1,1) size(im1,2),128]);
% disparity=zeros(size(im1,1), size(im1,2));
% dscr_ctr=1;
% for i=1:size(im1,1)
%     for j=1:size(im1,2)
%         %pixel_descriptor=zeros(1,size(im1,2));
%         temp1=double(d1_new(i,j,:));
%         t1=reshape(temp1,[128 1]);
%          temp2=double(d2_new(i,1:j,:));
%         t2=reshape(temp2,[j 128])';
%         t1_rep=repmat(t1,[1 j]);
%         pixel_descriptor=vecnorm(t1_rep-t2);
%          [minimum,index]=min(pixel_descriptor);
%          disparity(i,j)=abs(index-j);
%     end
%       
%         
%        
% end
% disp=disparity;
% end

function [disp] = DenseMatch(im1, im2)
    [H,W,~] = size(im1);
    [~,d1] = vl_dsift(single(padarray(rgb2gray(im1),[0 0],0,'symmetric')),'step',1,'size',1,'Geometry',[1 1 6]);
    [~,d2] = vl_dsift(single(padarray(rgb2gray(im2),[0 0],0,'symmetric')),'step',1,'size',1,'Geometry',[1 1 6]);
    num_features = min(size(d1));
    d1 = reshape(d1',[H W num_features]);
    d2 = reshape(d2',[H W num_features]);
    disp = zeros([H,W]);
    
%     im1_new=single(rgb2gray(im1));
%     im2_new=single(rgb2gray(im2));
%     im1_padded=zeros(size(im1,1)+9, size(im1,2)+9);
%     im2_padded=zeros(size(im1,1)+9, size(im1,2)+9);
%     for i=1:size(im1,1)
%         for j=1:size(im1,2)
%           im1_padded(i+5,j+5)=im1_new(i,j);
%           im2_padded(i+5,j+5)=im2_new(i,j);
%         end
%     end
%     [~, d1] = vl_dsift(single(im1_padded),'step',1) ;
%     [~, d2] = vl_dsift(single(im2_padded),'step',1) ;
%     num_features = min(size(d1));
%     d1=reshape(d1',[size(im1,1) size(im1,2),128]);
%     d2=reshape(d2',[size(im1,1) size(im1,2),128]);
%     disp=zeros(size(im1,1), size(im1,2));
    
    for i=1:size(im1,1)
        for j=1:size(im1,2)
            t1 = double(reshape(d1(i,j,:),[num_features,1]));
            t2 = double(reshape(d2(i,1:j,:),[j,num_features]))';
            t1_rep=repmat(t1,[1 j]);
            pixel_descriptor=vecnorm(t1_rep-t2);
            [~,index]=min(pixel_descriptor);
            disp(i,j)=abs(index-j);
        end
    end
end