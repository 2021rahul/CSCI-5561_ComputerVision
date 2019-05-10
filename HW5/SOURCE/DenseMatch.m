function [disp] = DenseMatch(im1, im2)
    im1=single(rgb2gray(im1));
    im2=single(rgb2gray(im2));
    im1_padded=zeros(size(im1,1)+9, size(im1,2)+9);
    im2_padded=zeros(size(im1,1)+9, size(im1,2)+9);
    for i=1:size(im1,1)
        for j=1:size(im1,2)
          im1_padded(i+5,j+5)=im1(i,j);
          im2_padded(i+5,j+5)=im2(i,j);
        end
    end
    [~, d1] = vl_dsift(single(im1_padded),'step',1) ;
    [~, d2] = vl_dsift(single(im2_padded),'step',1) ;
    num_features = min(size(d1));
    d1=reshape(d1',[size(im1,1) size(im1,2),128]);
    d2=reshape(d2',[size(im1,1) size(im1,2),128]);
    disp=zeros(size(im1,1), size(im1,2));
    
    for i=1:size(im1,1)
        for j=1:size(im1,2)
            t1 = double(reshape(d1(i,j,:),[num_features,1]));
            t2 = double(reshape(d2(i,1:j,:),[j,num_features]))';
            t1_rep=repmat(t1,[1 j]);
            pixel_descriptor=vecnorm(flip(t1_rep-t2));
            [~,index]=min(pixel_descriptor);
            disp(i,j)=abs(index-j);
        end
    end
    low = prctile(disp,10,'all');
    high = prctile(disp,98,'all');
    disp(disp<low) = low;
    disp(disp>high) = high;
    disp(im1==0)=0;
end