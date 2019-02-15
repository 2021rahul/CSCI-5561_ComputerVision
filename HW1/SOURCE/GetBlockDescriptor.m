function ori_histo_normalized = GetBlockDescriptor(ori_histo, block_size)
    ori_histo_size = size(ori_histo);
    ori_histo_normalized = zeros(ori_histo_size(1)-1, ori_histo_size(2)-1, block_size*block_size*ori_histo_size(3));
    for i=1:ori_histo_size(1)-(block_size-1)
        for j=1:ori_histo_size(2)-(block_size-1)
            ori_histo_block = ori_histo(i:i+block_size-1, j:j+block_size-1, :);
            ori_histo_normalized(i, j, :) = NormalizeLocal(ori_histo_block);
        end
    end   
end

function normalized_histo = NormalizeLocal(ori_histo_block)
    flattened_ori_histo = permute(ori_histo_block, [3,2,1]);
    flattened_ori_histo = flattened_ori_histo(:);
    denominator = sqrt(sum(flattened_ori_histo.^2) + 0.001^2);
    normalized_histo = flattened_ori_histo/denominator;
end