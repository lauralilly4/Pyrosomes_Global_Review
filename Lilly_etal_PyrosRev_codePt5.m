%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Codes for: 
%%%     Lilly et al. (in review). A Global Review of Pyrosomes:  
%%%     Shedding light on the ocean’s elusive gelatinous ‘fire-bodies’

% %% Part 4: Create histograms of a) depth distributions (7 spp., from 
%       Literature, JeDI, GBIF) and b) DVM distance (P.atlanticum only, 
%       Literature only)




%% ======= Plot Histograms =======
% Plot histograms by: i) separate species, with ii) each data source separate
colsvec = [[0 0 0];[0.5 0.5 0.5];[1 1 1]];

% Histo #1: Pyrosoma spp.
% Set bin edges
edges = 0:100:800;
% Change all values >700 -> '701' (for a '>700' bin)
pspp_lit_depcut = obsdepplg_dynot;
pspp_lit_depcut(pspp_lit_depcut>700) = 701;
pspp_jdi_depcut = jdi_pspp_cln.Depth_avg;
pspp_jdi_depcut(pspp_jdi_depcut>700) = 701;
pspp_gbf_depcut = str2double(cellstr(gbf_pspp_cln.Depth));
pspp_gbf_depcut(pspp_gbf_depcut>700) = 701;
% Get counts of each dataset within each bin
pspp_lit = histcounts(pspp_lit_depcut,edges);
pspp_jdi = histcounts(pspp_jdi_depcut,edges);
pspp_gbf = histcounts(pspp_gbf_depcut,edges);
pspp_emp = zeros(1,length(edges)-1); % Empty vector to placehold on 'left' and 'right' graphs below

f1 = figure(1)
leftcol = [0 0 0];
rightcol = [0 0 0];
set(f1,'defaultAxesColorOrder',[leftcol; rightcol]);
% JDI, GBF
yyaxis left
b1 = bar(edges(1:end-1),[pspp_emp;pspp_jdi;pspp_gbf]');
ylim([0,200]);
for c = 1:length(b1)
    b1(c).FaceColor = colsvec(c,:);
end
set(gca,'TickDir','out','FontSize',18);
box off
% Literature only - separate y-axis scale
yyaxis right
b2 = bar(edges(1:end-1),[pspp_lit;pspp_emp;pspp_emp]');
ylim([0,6]);
for c = 1:length(b2)
    b2(c).FaceColor = colsvec(c,:);
end
set(gca,'TickDir','out','FontSize',18);
box off
xticklabels({'0-100','100-200','200-300','300-400','400-500','500-600','600-700','>700'});
legend({'Literature (n=14)','JeDI (n=629)','GBIF (n=807)'},'FontSize',16);
hold off



% Histo #2: P. atlanticum
% Set bin edges
edges = 0:100:800;
% Change all values >700 -> '701' (for a '>700' bin)
patl_jdi_depcut = jdi_patl_cln.Depth_avg;
patl_jdi_depcut(patl_jdi_depcut>700) = 701;
patl_gbf_depcut = str2double(cellstr(gbf_patl_cln.Depth));
patl_gbf_depcut(patl_gbf_depcut>700) = 701;
% Get counts of each dataset within each bin
patl_jdi = histcounts(patl_jdi_depcut,edges);
patl_gbf = histcounts(patl_gbf_depcut,edges);

f2 = figure(2)
leftcol = [0 0 0];
rightcol = [0 0 0];
set(f2,'defaultAxesColorOrder',[leftcol; rightcol]);
yyaxis left
% JDI, GBF
b1 = bar(edges(1:end-1),[patl_jdi;pspp_emp]');
ylim([0,15]);
for b = 1:length(b1)
    b1(b).FaceColor = colsvec(b+1,:);
end
yyaxis right
b2 = bar(edges(1:end-1),[pspp_emp;patl_gbf]');
for b = 1:length(b2)
    b2(b).FaceColor = colsvec(b+1,:);
end
ylim([0,2000]);
set(gca,'TickDir','out','FontSize',18);
box off
xticklabels({'0-100','100-200','200-300','300-400','400-500','500-600','600-700','>700'});
legend({'JeDI (n=81)','GBIF (n=4008)'},'FontSize',16);
hold off



% Histo #3: COMBO (Pyrostremma spp., Pr. spinosum, Pr. agassizi,
% Pyrosomella spp., Pl. verticillata)
% Set bin edges
edges = 0:100:800;
% Change all values >700 -> '701' (for a '>700' bin)
% Pyrostremma spp.
tspp_gbf_depcut = gbf_tspp_cln.Depth;
tspp_gbf_depcut(tspp_gbf_depcut>700) = 701;
% Get counts of each dataset within each bin
tspp_gbf = histcounts(tspp_gbf_depcut,edges);

% Pr. spinosum
tspi_jdi_depcut = jdi_tspi_cln.Depth_avg;
tspi_jdi_depcut(tspi_jdi_depcut>700) = 701;
tspi_gbf_depcut = gbf_tspi_cln.Depth;
tspi_gbf_depcut(tspi_gbf_depcut>700) = 701;
% Get counts of each dataset within each bin
tspi_jdi = histcounts(tspi_jdi_depcut,edges);
tspi_gbf = histcounts(tspi_gbf_depcut,edges);

% Pr. agassizi
taga_gbf_depcut = gbf_taga_cln.Depth;
taga_gbf_depcut(taga_gbf_depcut>700) = 701;
% Get counts of each dataset within each bin
taga_gbf = histcounts(taga_gbf_depcut,edges);

% Pyrosomella spp. 
lspp_gbf_depcut = gbf_lspp_cln.Depth;
lspp_gbf_depcut(lspp_gbf_depcut>700) = 701;
% Get counts of each dataset within each bin
lspp_gbf = histcounts(lspp_gbf_depcut,edges);

% Pl. verticillata
lver_jdi_depcut = jdi_lver_cln.Depth_avg;
lver_jdi_depcut(lver_jdi_depcut>700) = 701;
lver_gbf_depcut = gbf_lver_cln.Depth;
lver_gbf_depcut(lver_gbf_depcut>700) = 701;
% Get counts of each dataset within each bin
lver_jdi = histcounts(lver_jdi_depcut,edges);
lver_gbf = histcounts(lver_gbf_depcut,edges);

f3 = figure(3)
leftcol = [0 0 0];
rightcol = [0 0 0];
set(f3,'defaultAxesColorOrder',[leftcol; rightcol]);
% JDI, GBF
b3 = bar(edges(1:end-1),[tspp_gbf;tspi_jdi;tspi_gbf;taga_gbf;lspp_gbf;lver_jdi;lver_gbf]',0.85);
ylim([0,6]);

for b = 1:length(b3)
    if b == 2
        b3(b).FaceColor = colsvec(1,:);
    else
        b3(b).FaceColor = colsvec(3,:);
    end
end
hatchfill2(b3(1),'single','HatchAngle',0,'hatchcolor',colsvec(2,:));
hatchfill2(b3(4),'single','HatchAngle',45,'hatchcolor',colsvec(2,:));
hatchfill2(b3(5),'single','HatchAngle',-45,'hatchcolor',colsvec(2,:));
hatchfill2(b3(6),'cross','HatchAngle',30,'hatchcolor',colsvec(1,:));
hatchfill2(b3(7),'cross','HatchAngle',45,'hatchcolor',colsvec(2,:));

set(gca,'TickDir','out','FontSize',18);
box off
xticklabels({'0-100','100-200','200-300','300-400','400-500','500-600','600-700','>700'});
legend([b3(1),b3(2),b3(3),b3(4),b3(5),b3(6),b3(7)],...
    {'Pyrostremma spp. - GBIF (n=1)','Pr. spinosum - JeDI (n=2)','Pr. spinosum - GBIF (n=13)','Pr. agassizi - GBIF (n=5)',...
    'Pyrosomella spp. - GBIF (n=8)','Pl. verticillata - JeDI (n=3)','Pl. verticillata - GBIF (n=6)'},'FontSize',16);
hold off



% Histo #4: P. atlanticum - DVM
edge4 = [0,100,200,600];
lit_dvm = histcounts(obsdvm,edge4);

f4 = figure(4)
b4 = bar(edge4(1:end-1),lit_dvm,0.3);
b4.FaceColor = [1 1 1];
ylim([0,5]);
set(gca,'TickDir','out','FontSize',18);
box off
xticklabels({'0-100','100-200','200-600'});
yticks([0,1,2,3,4,5]);
yticklabels({'0',' ','2',' ','4',' '});












% % Histo #4: Pr. spinosum
% % Set bin edges
% edges = 0:100:750;
% % Change all values >700 -> '701' (for a '>700' bin)
% 
% 
% f4 = figure(4)
% leftcol = [0 0 0];
% rightcol = [0 0 0];
% set(f4,'defaultAxesColorOrder',[leftcol; rightcol]);
% % JDI, GBF
% b1 = bar(edges(1:end-1),[tspi_jdi;tspi_gbf]');
% % ylim([0,200]);
% for c = 1:length(b1)
%     b1(c).FaceColor = colsvec(c,:);
% end
% set(gca,'TickDir','out','FontSize',18);
% box off
% legend({'JeDI','GBIF'},'FontSize',16);
% hold off
% 
% 
% 
% % Histo #5: Pr. agassizi
% % Set bin edges
% edges = 0:100:750;
% % Change all values >700 -> '701' (for a '>700' bin)
% f5 = figure(5)
% leftcol = [0 0 0];
% rightcol = [0 0 0];
% set(f5,'defaultAxesColorOrder',[leftcol; rightcol]);
% % JDI, GBF
% b1 = bar(edges(1:end-1),[taga_gbf]');
% % ylim([0,200]);
% for c = 1:length(b1)
%     b1(c).FaceColor = colsvec(c,:);
% end
% set(gca,'TickDir','out','FontSize',18);
% box off
% legend({'GBIF'},'FontSize',16);
% hold off
% 
% 
% 
% % Histo #6: Pyrosomella spp.
% % Set bin edges
% edges = 0:100:750;
% % Change all values >700 -> '701' (for a '>700' bin)
% f6 = figure(6)
% leftcol = [0 0 0];
% rightcol = [0 0 0];
% set(f6,'defaultAxesColorOrder',[leftcol; rightcol]);
% % JDI, GBF
% b1 = bar(edges(1:end-1),[lspp_gbf]');
% % ylim([0,200]);
% for c = 1:length(b1)
%     b1(c).FaceColor = colsvec(c,:);
% end
% set(gca,'TickDir','out','FontSize',18);
% box off
% legend({'GBIF'},'FontSize',16);
% hold off
% 
% 
% 
% % Histo #7: Pyrosomella verticillata
% % Set bin edges
% edges = 0:100:750;
% % Change all values >700 -> '701' (for a '>700' bin)
% f7 = figure(7)
% leftcol = [0 0 0];
% rightcol = [0 0 0];
% set(f7,'defaultAxesColorOrder',[leftcol; rightcol]);
% % JDI, GBF
% b1 = bar(edges(1:end-1),[lver_jdi;lver_gbf]');
% % ylim([0,200]);
% for c = 1:length(b1)
%     b1(c).FaceColor = colsvec(c,:);
% end
% set(gca,'TickDir','out','FontSize',18);
% box off
% legend({'JeDI','GBIF'},'FontSize',16);
% hold off


