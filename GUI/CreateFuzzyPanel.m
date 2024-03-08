function CreateFuzzyPanel( source,event )
global Strings
    
a=1/8;
b=5/37;
labels = Strings.fuzzylim.labels;
units = Strings.fuzzylim.units;
load('./data/CurrentVars.mat','var');
        for j=1:5
            if(1+2*(j-1)<=length(Strings.fuzzylim.labels))         
            uicontrol('Parent',source.Parent,...
                               'Style','text',...
                               'String',labels(1+2*(j-1)),...
                               'Units','normalized',...
                               'Position',[0,1-(a/2+a)*j,b,a]);
            uicontrol('Parent',source.Parent,...
                               'Style','edit',...
                               'Units','normalized',...
                               'Position',[b,1-(a/2+a)*j,b,a],...
                               'String',var.(labels{1+2*(j-1)})(2),...
                               'Tag',[labels{1+2*(j-1)},'_min'],...
                               'Callback',@savedata);
            uicontrol('Parent',source.Parent,...
                               'Style','text',...
                               'String',',',...
                               'Units','normalized',...
                               'Position',[2*b,1-(a/2+a)*j,b/5,a]);
            uicontrol('Parent',source.Parent,...
                               'Style','edit',...
                               'Units','normalized',...
                               'Position',[2*b+b/5,1-(a/2+a)*j,b,a],...
                               'String',var.(labels{1+2*(j-1)})(1),...
                               'Tag',[labels{1+2*(j-1)},'_max'],...
                               'Callback',@savedata);
            uicontrol('Parent',source.Parent,...
                               'Style','text',...
                               'String',units(1+2*(j-1)),...
                               'Units','normalized',...
                               'Position',[3*b+b/5,1-(a/2+a)*j,b/2,a]);
            end
            if(2*j<=length(labels))
                     uicontrol('Parent',source.Parent,...
                               'Style','text',...
                               'String',labels(2*j),...
                               'Units','normalized',...
                               'Position',[3*b+b/5+b/2,1-(a/2+a)*j,b,a]);
                     uicontrol('Parent',source.Parent,...
                               'Style','edit',...
                               'Units','normalized',...
                               'Position',[4*b+b/5+b/2,1-(a/2+a)*j,b,a],...
                               'String',var.(labels{2*j})(2),...
                               'Tag',[labels{2*j},'_min'],...
                               'Callback',@savedata);
                     uicontrol('Parent',source.Parent,...
                               'Style','text',...
                               'String',',',...
                               'Units','normalized',...
                               'Position',[5*b+b/2+b/5,1-(a/2+a)*j,b/5,a]);
                     uicontrol('Parent',source.Parent,...
                               'Style','edit',...
                               'Units','normalized',...
                               'Position',[5*b+b/2+2*b/5,1-(a/2+a)*j,b,a],...
                               'String',var.(labels{2*j})(1),...
                               'Tag',[labels{2*j},'_max'],...
                               'Callback',@savedata);
                     uicontrol('Parent',source.Parent,...
                               'Style','text',...
                               'String',units(2*j),...
                               'Units','normalized',...
                               'Position',[1-b/2,1-(a/2+a)*j,b/2,a]);
            end
        end

save('data/CurrentVars','var')
end

