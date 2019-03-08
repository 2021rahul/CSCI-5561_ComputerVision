function [] = DrawBox(A, template, target)
    [h, w]=size(template);
    template1 = [1,1];
    template2 = [w,1];
    template3 = [w, h];
    template4 = [1,h];

    target1 = [A*[template1 1]']';
    target1 = target1(1:2);
    target2 = [A*[template2 1]']';
    target2 = target2(1:2);
    target3 = [A*[template3 1]']';
    target3 = target3(1:2);
    target4 = [A*[template4 1]']';
    target4 = target4(1:2);

    width = target2(1)-target1(1);
    height = target4(2)-target1(2);
    
    figure(2);
%     subplot(1,1,1), imshow(target), hold on, rectangle('Position', [target1(1) target1(2) width height], 'EdgeColor', 'r');
    subplot(1,1,1), imshow(target);
    hold on, plot(fliplr(target1), fliplr(target2), 'color', 'red');
    hold on, plot(fliplr(target2), fliplr(target3), 'color', 'blue');
    hold on, plot(fliplr(target3), fliplr(target4), 'color', 'green');
    hold on, plot(fliplr(target4), fliplr(target1), 'color', 'yellow');
end