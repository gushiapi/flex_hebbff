function multiple_boxplot_bee_bar(data,xlab,Mlab,colors)
% data is a cell matrix of LxM where in each element there is a array of N
% length. M is how many data for the same group, L, how many groups.
%
% Optional:
% xlab is a cell array of strings of length L with the names of each
% group
%
% Mlab is a cell array of strings of length M
%
% colors is a Mx4 matrix with normalized RGBA colors for each M.
% check that data is ok.
if ~iscell(data)
    error('Input data is not even a cell array!');
end
M = 1;
% Get sizes
L=numel(data);
if nargin>=4
    if size(colors,2)~=M
        error('Wrong amount of colors!');
    end
end
if nargin>=2
    if length(xlab)~=L
        error('Wrong amount of X labels given');
    end
end


% Calculate the positions of the boxes
positions=1:0.25:M*L*0.25+1+0.25*L;
positions(1:M+1:end)=[];
% Extract data and label it in the group correctly
x=[];
group=[];
for ii=1:L
    for jj=1:M
        aux=data{ii,jj};
        x=vertcat(x,aux(:));
        group=vertcat(group,ones(size(aux(:)))*jj+(ii-1)*M);
    end
end


% Get some colors
if nargin>=4
    cmap=colors;
else
    cmap = hsv(M);
    cmap=vertcat(cmap',ones(1,M)*0.5);
end
color=repmat(cmap, 1, L);

% Plot it
% boxplot(x,group, 'positions', positions,'Notch','on');

for i = 1:max(group)
    dataSpreadGroup{i} = x(group==i);
    groupMean(i) = nanmean(dataSpreadGroup{i});
    groupStdErr(i) = nanstd(dataSpreadGroup{i})/sqrt(size(dataSpreadGroup{i},1));
end
plotSpread(dataSpreadGroup,'spreadWidth',0.5,'distributionColors',color(1:3,:)','xValues',positions,'showMM',0);
% b = bar(positions,groupMean,0.6);
b = errorbar(positions, groupMean, groupStdErr);
b.FaceColor = 'flat';
% b.CData = color(1:3,:)';
b.FaceAlpha = 0.25;
b.LineWidth = 1.25;
b.EdgeColor = [0.2,0.2,0.2];
errorbar(positions, groupMean, groupStdErr,'.','capsize',16,'linewidth',1.25,'color',[0.2,0.2,0.2]);


% yt = get(gca, 'YTick');
% for k = 1:numel(positions)
%     if pValues(k) < 0.001
%         text(positions(k), max(yt)*(0.55+0.1), '***','HorizontalAlignment','center','FontSize',15);
%         hold on;
%     elseif pValues(k) < 0.01
%         text(positions(k), max(yt)*(0.55+0.1), '**','HorizontalAlignment','center','FontSize',15);
%         hold on;
%     elseif pValues(k) < 0.05
%         hold on;
%         text(positions(k), max(yt)*(0.55+0.1), '*','HorizontalAlignment','center','FontSize',15);
%         hold on;
%     else
%         text(positions(k), max(yt)*(0.55+0.1), 'n.s.','HorizontalAlignment','center','FontSize',15);
%         hold on;
%     end
% end
% 
% 
% 
% % Set the Xlabels
% aux=reshape(positions,M,[]);
% labelpos = sum(aux,1)./M;
% set(gca,'xtick',labelpos)
% if nargin>=2
%     set(gca,'xticklabel',xlab,'FontSize',15);
% else
%     idx=1:L;
%     set(gca,'xticklabel',strsplit(num2str(idx),' '),'FontSize',15);
% end
%     


% 
% % Apply colors
% h = findobj(gca,'Tag','Box');
% for jj=1:length(h)
%    patch(get(h(jj),'XData'),get(h(jj),'YData'),color(1:3,jj)','FaceAlpha',color(4,jj));
% end


end