close all; clear all; clc;
%% Inputs
global Strings
addpath('GUI');
margin = 0.05;
VarStrings;
load('data/CurrentVars')

%% Elements
fig = figure('Name','Fuzzy Modelling Framework for Aircraft Systems','NumberTitle','off');
set(fig,'Menubar','none');
set(fig,'Units','normalized');
set(fig,'Position',[0,0.2,0.8,0.75]);
mainpanel = uipanel(fig,'Tag','mainpanel');
%% Inputs panels and buttons
for i=1:length(Strings.ButtonNames)
    uicontrol('Parent',mainpanel,...
              'Style','pushbutton',...
              'String',Strings.ButtonNames(i),...
              'Tag',Strings.ButtonNames{i},...
              'Units','normalized',...
              'Position',[0+(i-1)*0.1,1-margin,0.1,margin],...
              'Callback',@SelectPanel);
end
source = findobj('Tag','mig');
event=0;
SelectPanel(source,event)
    uicontrol('Parent',mainpanel,...
              'Style','pushbutton',...
              'String','load',...
              'Units','normalized',...
              'Position',[0,0.5-margin,0.1,margin],...
              'Callback',@selectmodel);
    uicontrol('Parent',mainpanel,...
              'Style','pushbutton',...
              'String','save',...
              'Units','normalized',...
              'Position',[0.1,0.5-margin,0.1,margin],...
              'Callback',@savemodel);     
    uicontrol('Parent',mainpanel,...
              'Style','pushbutton',...
              'String','clear',...
              'Units','normalized',...
              'Position',[0.2,0.5-margin,0.1,margin],...
              'Callback',@cleardata);
    uicontrol('Parent',mainpanel,...
              'Style','pushbutton',...
              'Units','normalized',...
              'Tag','help',...
              'Position',[0.4,0.5-margin,0.1,margin],...
              'String','Model description',...
              'Callback','open doc/Model_Description.pdf');
    
%% Fuzzy panel input
    fuzzypanel =uipanel('Parent',mainpanel,...
            'Title','Fuzzy Model Limits',...
            'Units','normalized',...
            'Tag','fuzzypanel',...
            'Position',[0,0,0.5,0.5-margin]);
        defaultButton =uicontrol('Parent',fuzzypanel,...
              'Style','pushbutton',...
              'Units','normalized',...
              'Tag','defaultfuzzy',...
              'Position',[1-0.1*4,0,0.1*2,margin*2],...
              'String','Default',...
              'Callback',@defaultlimits);  
        uicontrol('Parent',fuzzypanel,...
              'Style','pushbutton',...
              'Units','normalized',...
              'Tag','createfuzzy',...
              'Position',[1-0.1*2,0,0.1*2,margin*2],...
              'String','Create',...
              'Callback',@CreateFuzzyModel);       
source = defaultButton;
event=0;
CreateFuzzyPanel(source,event)

%% MF plot planel
mfpanel =uipanel('Parent',mainpanel,...
            'Title','Membership function plot',...
            'Units','normalized',...
            'Tag','fuzzypanel',...
            'Position',[0.5,0,0.5,0.7-margin]);
           
        uicontrol('Parent',mfpanel,...
              'Style','popup',...
              'Units','normalized',...
              'Position',[0.5,0.8,0.3,0.1],...
              'String',Strings.mf.labels,...
              'Tag','mfvar');
        uicontrol('Parent',mfpanel,...
                  'Style','pushbutton',...
                  'Units','normalized',...
                  'String','Plot Membership',...
                  'Position',[0.1,0.8,0.3,0.1],...
                  'Callback',@plotmf)
                  
      fuzzyrules=uipanel('Parent',mfpanel,...
                'Units','normalized',...
                'Tag','fuzzydes',...
                'Position',[0.05,0.2,0.9,0.4]);
              a=  axes('Parent',fuzzyrules,...
                     'Position',[0,0,1,1]);  
            [x,map]=imread('resources/fuzzy_rules.JPG');
            x = imresize(x,3);
            imagesc(x)
            set(a,'Visible','off')

%% Simulation panel

simpanel = uipanel('Parent',mainpanel,...
            'Title','Simulation',...
            'Units','normalized',...
            'Tag','simpanel',...
            'Position',[0.5,0.7-margin,0.5,1-0.7+margin]);
           uicontrol('Parent',simpanel,...
                     'Style','text',...
                     'Units','normalized',...
                     'Position',[1/5/2,0.15/2,1/5,0.15],...
                     'String','Simulation time (s)')
           uicontrol('Parent',simpanel,...
                     'Style','edit',...
                     'Units','normalized',...
                     'Position',[1/5/2+1/5,0.15/2,1/5-0.1,0.15],...
                     'Tag','simtime',...
                     'String',var.simtime,...
                     'Callback',@savedata)
           uicontrol('Parent',simpanel,...
                     'Style','pushbutton',...
                     'Units','normalized',...
                     'Position',[0.6,0.15/2,0.3,0.15],...
                     'String','Simulate',...
                     'Callback',@Simulation)
siminputpanel=uipanel('Parent',simpanel,...
                      'Title','Inputs',...
                      'Units','normalized',...
                      'Position',[0.05,0.3,0.4,0.7]);
                  
            uicontrol('Parent',siminputpanel,...
                     'Style','pushbutton',...
                     'Units','normalized',...
                     'Position',[0.2,0.2,0.6,0.3],...
                     'String','Actuators',...
                     'Callback',@ActuatorsWindow)
            uicontrol('Parent',siminputpanel,...
                     'Style','pushbutton',...
                     'Units','normalized',...
                     'Position',[0.2,0.6,0.6,0.3],...
                     'String','Init Conditions',...
                     'Callback',@InitialConditionsWindow)

simoutputpanel=uipanel('Parent',simpanel,...
                      'Title','Outputs',...
                      'Units','normalized',...
                      'Position',[0.55,0.3,0.4,0.7]);
            uicontrol('Parent',simoutputpanel,...
                     'Style','pushbutton',...
                     'Units','normalized',...
                     'Position',[0.2,0.2,0.6,0.3],...
                     'String','Plot',...
                     'Callback',@PlotResults)
            uicontrol('Parent',simoutputpanel,...
                     'Style','popup',...
                     'Units','normalized',...
                     'Position',[0.2,0.6,0.6,0.3],...
                     'Tag','SelectStatesVar',...
                     'String',Strings.StatesVar.labels)
                 
           
                 