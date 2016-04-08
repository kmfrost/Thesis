function confusionMatrix(mat, labels)
mat = mat.';
assert(size(mat,1) == size(mat,2));
N = size(mat,1);

assert(iscellstr(labels));
assert(length(labels) == N);

figure('Position',[20,130,750,625]); axis equal; hold on; box on;
axis([0,N,0,N]+0.5);

mat2 = (mat./repmat(sum(mat,1),N,1)).';
im = imagesc(mat2);

% !!! Pick your colormap
% cm=viridis();
% cm=plasma();
 cm=inferno();
% cm=magma();
% cm = parula();

% !!! Uncomment this (and change the 0.8 to whatever) to fade the colors
cm = 1-((1-cm)*0.8);

colormap(cm); caxis([0,1]);
cb = colorbar;
set(cb, 'YTickLabel', linspace(0,100,11))

for idx = 0:N
    plot([0,N]+0.5,idx*[1,1]+0.5,'k','linew',2);
    plot(idx*[1,1]+0.5,[0,N]+0.5,'k','linew',2);
end

for xidx = 1:N
    for yidx = 1:N
        rsum = sum(mat(:,yidx));
        % !!! Change these values to set what value range to use black text
        if (mat(xidx,yidx)/rsum >= 0.4) && (mat(xidx,yidx)/rsum <= 1.0)
            c = 'k';
        else
            c = 'w';
        end
        text(xidx,yidx,sprintf('%d\n',mat(xidx,yidx)),...
            'fontSize',13,'HorizontalAlignment','center','fontWeight','bold','Color',c);
        text(xidx,yidx,sprintf('\n%0.2f%%',mat(xidx,yidx)/rsum*100),...
            'fontSize',13,'HorizontalAlignment','center','Color',c);
    end
end

set(gca,'Ydir','reverse');
set(gca,'XAxisLocation','top','XTickLabelRotation',45);
set(gca,'XTick',(1:N),'TickLength',[0,0],'XTickLabel',labels);
set(gca,'YTick',(1:N),'TickLength',[0,0],'YTickLabel',labels);
set(gca,'FontSize',12);

xlabel('Output Class','FontSize',18);
ylabel('Target Class','FontSize',18);
