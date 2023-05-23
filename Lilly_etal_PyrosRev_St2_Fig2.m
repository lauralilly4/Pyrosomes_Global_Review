%%%%%%%%%%%%%%
%%% Codes for: 
%%%     Lilly et al. (in review). A Global Review of Pyrosomes:  
%%%     Shedding light on the ocean’s elusive gelatinous ‘fire-bodies’

% %% Part 7: Plot Habitat Envelopes (Temperature, Chl-a) for each pyrosome
%               species
% %% NOTE: Temperature/Chl-Pyrosome "matchup" files were pre-subsetted from
%   original full Temperature/Chl files. Subsetting code available upon request.
%   - Temperature: https://psl.noaa.gov/data/gridded/data.noaa.oisst.v2.highres.html
%   - Chl-a (monthly): http://data.europa.eu/89h/10161412-a76c-42b0-b4e1-5fcccdc412b2
%   - Chl-a (climatology): https://data.jrc.ec.europa.eu/dataset/41b070fa-fef5-4816-b60d-7e5a186e197e


%% ======= Load (pre-subsetted) matchup files =======
tmpfl = readtable('Pyros_Temp_match.csv');
chlfl = readtable('Pyros_Chla_match.csv');

% Get list of unique species names --> to get subset arrays for each
sppnms = unique(tmpfl.sppnmsvar);

% Pyrosoma spp.
pspp_sst = table2array(tmpfl(find(strcmp(tmpfl.sppnmsvar,sppnms{7,:})),7));
pspp_chl = table2array(chlfl(find(strcmp(chlfl.sppnmsvar,sppnms{7,:})),7));
% P. atlanticum
patl_sst = table2array(tmpfl(find(strcmp(tmpfl.sppnmsvar,sppnms{2,:})),7));
patl_chl = table2array(chlfl(find(strcmp(chlfl.sppnmsvar,sppnms{2,:})),7));
% P. aherniosum
pahe_sst = table2array(tmpfl(find(strcmp(tmpfl.sppnmsvar,sppnms{1,:})),7));
pahe_chl = table2array(chlfl(find(strcmp(chlfl.sppnmsvar,sppnms{1,:})),7));
% P. ovatum
pova_sst = table2array(tmpfl(find(strcmp(tmpfl.sppnmsvar,sppnms{3,:})),7));
pova_chl = table2array(chlfl(find(strcmp(chlfl.sppnmsvar,sppnms{3,:})),7));
% Pyrostremma spp. 
tspp_sst = table2array(tmpfl(find(strcmp(tmpfl.sppnmsvar,sppnms{9,:})),7));
tspp_chl = table2array(chlfl(find(strcmp(chlfl.sppnmsvar,sppnms{9,:})),7));
% Pr. spinosum
tspi_sst = table2array(tmpfl(find(strcmp(tmpfl.sppnmsvar,sppnms{6,:})),7));
tspi_chl = table2array(chlfl(find(strcmp(chlfl.sppnmsvar,sppnms{6,:})),7));
% Pr. agassizi
taga_sst = table2array(tmpfl(find(strcmp(tmpfl.sppnmsvar,sppnms{5,:})),7));
taga_chl = table2array(chlfl(find(strcmp(chlfl.sppnmsvar,sppnms{5,:})),7));
% Pyrosomella spp.
lspp_sst = table2array(tmpfl(find(strcmp(tmpfl.sppnmsvar,sppnms{8,:})),7));
lspp_chl = table2array(chlfl(find(strcmp(chlfl.sppnmsvar,sppnms{8,:})),7));
% Pl. verticillata
lver_sst = table2array(tmpfl(find(strcmp(tmpfl.sppnmsvar,sppnms{4,:})),7));
lver_chl = table2array(chlfl(find(strcmp(chlfl.sppnmsvar,sppnms{4,:})),7));


%% ======= Boxplots: Temperature ========
% %% Temperature
figure(21);
pp1 = panel();
pp1.pack('h',7);

% Subplot 1 - Pyrosoma spp.
pp1(1).select();
bp1 = boxplot(pspp_sst,'Orientation','vertical','Widths',1);
xlim([-1.5,1.5]);
ylim([-5,35]);
yticks([0,10,20,30]);
set(bp1,'LineWidth',1.5);
bwd1 = findobj(gca,'tag','box');
set(bwd1,'linewidth',1.5);
h1 = findobj(gca,'tag','Median');
set(h1,'LineWidth',2,'Color','k');
set(gca,'box','off','YTickLabel',[],'XTick',[],'TickDir','out');

% % Subplot 2 - P. atlanticum
pp1(2).select();
bp2 = boxplot(patl_sst,'Orientation','vertical','Widths',1);
xlim([-1.5,1.5]);
ylim([-5,35]);
yticks([0,10,20,30]);
set(bp2,'LineWidth',1.5);
bwd2 = findobj(gca,'tag','box');
set(bwd2,'linewidth',1.5);
h2 = findobj(gca,'tag','Median');
set(h2,'LineWidth',2,'Color','k');
set(gca,'box','off','YTickLabel',[],'XTick',[],'TickDir','out');

% % Subplot 3 - P. aherniosum, Pyrostremma spp. 
pp1(3).select();
hold on
bp31 = scatter(repmat(1,length(pahe_sst),1),pahe_sst,60,'square','k');
bp32 = scatter(repmat(-1,length(tspp_sst),1),tspp_sst,60,'square','filled','k');
hold off
xlim([-1.5,1.5]);
ylim([-5,35]);
yticks([0,10,20,30]);
set(gca,'box','off','YTickLabel',[],'XTick',[],'TickDir','out');

% Subplot 4 - Pr. spinosum 
pp1(4).select();
bp14 = boxplot(tspi_sst,'Orientation','vertical','Widths',1);
xlim([-1.5,1.5]);
ylim([-5,35]);
yticks([0,10,20,30]);
set(bp14,'LineWidth',1.5);
bwd14 = findobj(gca,'tag','box');
set(bwd14,'linewidth',1.5);
hr14 = findobj(gca,'tag','Median');
set(hr14,'LineWidth',2,'Color','k');
set(gca,'box','off','YTickLabel',[],'XTick',[],'TickDir','out');

% Subplot 5 - Pr. agassizi 
pp1(5).select();
bp23 = boxplot(taga_sst,'Orientation','vertical','Widths',1);
xlim([-1.5,1.5]);
ylim([-5,35]);
yticks([0,10,20,30]);
set(bp23,'LineWidth',1.5);
bwd23 = findobj(gca,'tag','box');
set(bwd23,'linewidth',1.5);
hr23 = findobj(gca,'tag','Median');
set(hr23,'LineWidth',2,'Color','k');
set(gca,'box','off','YTickLabel',[],'XTick',[],'TickDir','out');

% Subplot 6 - Pyrosomella spp. 
pp1(6).select();
bp24 = boxplot(lspp_sst,'Orientation','vertical','Widths',1);
xlim([-1.5,1.5]);
ylim([-5,35]);
yticks([0,10,20,30]);
set(bp24,'LineWidth',1.5);
bwd24 = findobj(gca,'tag','box');
set(bwd24,'linewidth',1.5);
hr24 = findobj(gca,'tag','Median');
set(hr24,'LineWidth',2,'Color','k');
set(gca,'box','off','YTickLabel',[],'XTick',[],'TickDir','out');

% Subplot 7 - Pl. verticillata
pp1(7).select();
bp25 = boxplot(lver_sst,'Orientation','vertical','Widths',1);
xlim([-1.5,1.5]);
ylim([-5,35]);
yticks([0,10,20,30]);
set(bp25,'LineWidth',1.5);
bwd25 = findobj(gca,'tag','box');
set(bwd25,'linewidth',1.5);
h25 = findobj(gca,'tag','Median');
set(h25,'LineWidth',2,'Color','k');
set(gca,'box','off','YTickLabel',[],'XTick',[],'TickDir','out');
% 
% % EMPTY
% pp2(4).select();
% xlim([-1.5,1.5]);
% ylim([-5,35]);
% yticks([0,10,20,30]);
% set(gca,'box','off','XTickLabel',[],'YTick',[],'TickDir','out');

pp1.de.margin = 2;
pp1.fontsize = 24;




%% ======= Boxplots: Chl-a ========
% %% Chlorophyll-a
figure(31);
pp31 = panel();
pp31.pack('h',7);

% Subplot 1 - Pyrosoma spp.
pp31(1).select();
bp31 = boxplot(pspp_chl,'Orientation','vertical','Widths',1);
xlim([-1.5,1.5]);
ylim([-1.5,1.5]);
yticks([-1.5,-0.5,0,0.5,1.5]);
set(bp31,'LineWidth',1.5);
bwd31 = findobj(gca,'tag','box');
set(bwd31,'linewidth',1.5);
h31 = findobj(gca,'tag','Median');
set(h31,'LineWidth',2,'Color','k');
set(gca,'box','off','YTickLabel',[],'XTick',[],'TickDir','out');

% % Subplot 2 - P. atlanticum
pp31(2).select();
bp32 = boxplot(patl_chl,'Orientation','vertical','Widths',1);
xlim([-1.5,1.5]);
ylim([-1.5,1.5]);
yticks([-1.5,-0.5,0,0.5,1.5]);
set(bp32,'LineWidth',1.5);
bwd32 = findobj(gca,'tag','box');
set(bwd32,'linewidth',1.5);
h32 = findobj(gca,'tag','Median');
set(h32,'LineWidth',2,'Color','k');
set(gca,'box','off','YTickLabel',[],'XTick',[],'TickDir','out');

% Subplot 3 - P. aherniosum, Pyrostremma spp
pp31(3).select();
hold on
bp33 = scatter(repmat(1,length(pahe_chl),1),pahe_chl,60,'square','k');
bp332 = scatter(repmat(-1,length(tspp_chl),1),tspp_chl,60,'square','filled','k');
hold on
xlim([-1.5,1.5]);
ylim([-1.5,1.5]);
yticks([-1.5,-0.5,0,0.5,1.5]);
set(gca,'box','off','YTickLabel',[],'XTick',[],'TickDir','out');

% Subplot 4 - Pr. spinosum
pp31(4).select();
bp34 = boxplot(tspi_chl,'Orientation','vertical','Widths',1);
xlim([-1.5,1.5]);
ylim([-1.5,1.5]);
yticks([-1.5,-0.5,0,0.5,1.5]);
set(bp34,'LineWidth',1.5);
bwd34 = findobj(gca,'tag','box');
set(bwd34,'linewidth',1.5);
h34 = findobj(gca,'tag','Median');
set(h34,'LineWidth',2,'Color','k');
set(gca,'box','off','YTickLabel',[],'XTick',[],'TickDir','out');

% Subplot 5 - P. agassizi
pp31(5).select();
bp35 = boxplot(taga_chl,'Orientation','vertical','Widths',1);
xlim([-1.5,1.5]);
ylim([-1.5,1.5]);
yticks([-1.5,-0.5,0,0.5,1.5]);
set(bp35,'LineWidth',1.5);
bwd35 = findobj(bp35,'Tag','Box');
set(bwd35,'linewidth',1.5);
h35 = findobj(gca,'Tag','Median');
set(h35,'LineWidth',2,'Color','k');
set(gca,'box','off','YTickLabel',[],'XTick',[],'TickDir','out');

% Subplot 6 - Pyrosomella spp. 
pp31(6).select();
bp36 = boxplot(lspp_chl,'Orientation','vertical','Widths',1);
xlim([-1.5,1.5]);
ylim([-1.5,1.5]);
yticks([-1.5,-0.5,0,0.5,1.5]);
set(bp36,'LineWidth',1.5);
bwd36 = findobj(bp36,'Tag','Box');
set(bwd36,'linewidth',1.5);
h36 = findobj(gca,'Tag','Median');
set(h36,'LineWidth',2,'Color','k');
set(gca,'box','off','YTickLabel',[],'XTick',[],'TickDir','out');

% Subplot 7 - P. verticillata
pp31(7).select();
bp37 = boxplot(lver_chl,'Orientation','vertical','Widths',1);
xlim([-1.5,1.5]);
ylim([-1.5,1.5]);
yticks([-1.5,-0.5,0,0.5,1.5]);
set(bp37,'LineWidth',1.5);
bwd37 = findobj(bp37,'Tag','Box');
set(bwd37,'linewidth',1.5);
h37 = findobj(gca,'Tag','Median');
set(h37,'LineWidth',2,'Color','k');
set(gca,'box','off','YTickLabel',[],'XTick',[],'TickDir','out');

% % Subplot 8 - EMPTY
% pp32(4).select();
% xlim([-1.5,1.5]);
% ylim([0,5]);
% yticks([0,1,2,3,4,5]);
% set(gca,'box','off','XTickLabel',[],'YTick',[],'TickDir','out');
  
pp31.de.margin = 2;
pp31.fontsize = 24;
