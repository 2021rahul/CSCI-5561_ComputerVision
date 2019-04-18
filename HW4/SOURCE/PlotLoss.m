function [] = PlotLoss(loss,method)
    fig_handle = figure;
    clf;
    plot(loss);
    ylabel('Training Loss');
    xlabel('Iterations');
    saveas(fig_handle,'../RESULT/'+method+'_loss.png');
end