function [A_cell, template_cell] = TrackMultiFrames(template, image_cell)
    
    [x1, x2] = FindMatch(template,image_cell{1});
    A = AlignImageUsingFeature(x1, x2, 3, 500);
    A_cell = {A};
    template_cell = {template};
    for i=1:max(size(image_cell))
        A_cell{i+1} = AlignImage(template, image_cell{i}, A_cell{i});
        template = WarpImage(image_cell{i}, A_cell{i+1}, size(template));
        template_cell{i+1} = template;
    end
    A_cell = A_cell(2:max(size(A_cell)));
end

