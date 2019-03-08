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
    
    x = [target1(1) target2(1) target3(1) target4(1) target1(1)];
    y = [target1(2) target2(2) target3(2) target4(2) target1(2)];
    
    figure;
    hold on;
    subplot(1,1,1), imshow(target);
    hold on, plot(x, y, 'r');
    hold off;
end