%%%%%%%%%%%%%%
%%% Codes for: 
%%%     Lilly et al. (in review). A Global Review of Pyrosomes:  
%%%     Shedding light on the ocean’s elusive gelatinous ‘fire-bodies’

% %% Part 6: Create histograms of a) depth distributions (7 spp., from 
%       Literature, JeDI, GBIF, OBIS) and b) DVM distance (P.atlanticum only, 
%       Literature only)



%% ======= Plot Histograms =======
% Plot histograms by: i) separate species, with ii) each data source separate
colsvec = [[0 0 0];[0.3 0.3 0.3];[0.8 0.8 0.8];[1 1 1]];

% Histo #1: Pyrosoma spp.
% Set bin edges
edges = 0:100:800;
% Change all values >700 -> '701' (for a '>700' bin)
pspp_lit_depcut = lit_pspp_cln.Depth_avg;
pspp_lit_depcut(pspp_lit_depcut>700) = 701;
pspp_jdi_depcut = jdi_pspp_cln.Depth_avg;
pspp_jdi_depcut(pspp_jdi_depcut>700) = 701;
pspp_gbf_depcut = gbf_pspp_cln.Depth;
pspp_gbf_depcut(pspp_gbf_depcut>700) = 701;
pspp_obi_depcut = obi_pspp_cln.Depth_min;
pspp_obi_depcut(pspp_obi_depcut>700) = 701;
% Get counts of each dataset within each bin
pspp_lit = histcounts(pspp_lit_depcut,edges);
pspp_jdi = histcounts(pspp_jdi_depcut,edges);
pspp_gbf = histcounts(pspp_gbf_depcut,edges);
pspp_obi = histcounts(pspp_obi_depcut,edges);
pspp_emp = zeros(1,length(edges)-1); % Empty vector to placehold on 'left' and 'right' graphs below

f1 = figure(1)
leftcol = [0 0 0];
rightcol = [0 0 0];
set(f1,'defaultAxesColorOrder',[leftcol; rightcol]);
% JDI, GBF
yyaxis left
b1 = bar(edges(1:end-1),[pspp_emp;pspp_jdi;pspp_gbf;pspp_emp]');
ylim([0,220]);
for c = 1:length(b1)
    b1(c).FaceColor = colsvec(c,:);
end
set(gca,'TickDir','out','FontSize',18);
box off
% Literature only - separate y-axis scale
yyaxis right
% b2 = bar(edges(1:end-1),[pspp_lit;pspp_emp;pspp_emp;pspp_emp]');
b2 = bar(edges(1:end-1),[pspp_emp;pspp_emp;pspp_emp;pspp_obi]');
ylim([0,2000]);
for c = 1:length(b2)
    b2(c).FaceColor = colsvec(c,:);
end
set(gca,'TickDir','out','FontSize',18);
box off
xticklabels({'0-100','100-200','200-300','300-400','400-500','500-600','600-700','>700'});
legend(b2(2:4),{'JeDI (n=559)','GBIF (n=561)','OBIS (n=2035)'},'FontSize',16);
hold off



% Histo #2: P. atlanticum
% Set bin edges
edges = 0:100:800;
% Change all values >700 -> '701' (for a '>700' bin)
patl_lit_depcut = lit_patl_cln.Depth_avg;
patl_lit_depcut(patl_lit_depcut>700) = 701;
patl_jdi_depcut = jdi_patl_cln.Depth_avg;
patl_jdi_depcut(patl_jdi_depcut>700) = 701;
patl_gbf_depcut = gbf_patl_cln.Depth;
patl_gbf_depcut(patl_gbf_depcut>700) = 701;
patl_obi_depcut = obi_patl_cln.Depth_min;
patl_obi_depcut(patl_obi_depcut>700) = 701;
% Get counts of each dataset within each bin
patl_lit = histcounts(patl_lit_depcut,edges);
patl_jdi = histcounts(patl_jdi_depcut,edges);
patl_gbf = histcounts(patl_gbf_depcut,edges);
patl_obi = histcounts(patl_obi_depcut,edges);

f2 = figure(2)
leftcol = [0 0 0];
rightcol = [0 0 0];
set(f2,'defaultAxesColorOrder',[leftcol; rightcol]);
yyaxis left
% JDI, GBF
b1 = bar(edges(1:end-1),[patl_lit;patl_jdi;pspp_emp;patl_obi]');
% ylim([0,15]);
for b = 1:length(b1)
    b1(b).FaceColor = colsvec(b,:);
end
yyaxis right
b2 = bar(edges(1:end-1),[pspp_emp;pspp_emp;patl_gbf;pspp_emp]');
for b = 1:length(b2)
    b2(b).FaceColor = colsvec(b,:);
end
% ylim([0,2000]);
set(gca,'TickDir','out','FontSize',18);
box off
xticklabels({'0-100','100-200','200-300','300-400','400-500','500-600','600-700','>700'});
legend(b2,{'Literature(n=14)','JeDI (n=54)','GBIF (n=2972)','OBIS (n=297)'},'FontSize',16);
hold off



% Histo #3: ALL Pyrostremma groups(Pyrostremma spp., 
% Pr. spinosum, Pr. agassizi)
% Set bin edges
edges = 0:100:800;

% Pyrostremma spp.
tspp_gbf_depcut = gbf_tspp_cln.Depth;
tspp_gbf_depcut(tspp_gbf_depcut>700) = 701;
% Get counts of each dataset within each bin
tspp_gbf = histcounts(tspp_gbf_depcut,edges);

% Pr. spinosum
tspi_lit_depcut = lit_tspi_cln.Depth_avg;
tspi_lit_depcut(tspi_lit_depcut>700) = 701;
tspi_jdi_depcut = jdi_tspi_cln.Depth_avg;
tspi_jdi_depcut(tspi_jdi_depcut>700) = 701;
tspi_gbf_depcut = gbf_tspi_cln.Depth;
tspi_gbf_depcut(tspi_gbf_depcut>700) = 701;
tspi_obi_depcut = obi_tspi_cln.Depth_min;
tspi_obi_depcut(tspi_obi_depcut>700) = 701;
% Get counts of each dataset within each bin
tspi_lit = histcounts(tspi_lit_depcut,edges);
tspi_jdi = histcounts(tspi_jdi_depcut,edges);
tspi_gbf = histcounts(tspi_gbf_depcut,edges);
tspi_obi = histcounts(tspi_obi_depcut,edges);

% Pr. agassizi
taga_jdi_depcut = jdi_taga_cln.Depth_avg;
taga_jdi_depcut(taga_jdi_depcut>700) = 701;
taga_gbf_depcut = gbf_taga_cln.Depth;
taga_gbf_depcut(taga_gbf_depcut>700) = 701;
taga_obi_depcut = obi_taga_cln.Depth_min;
taga_obi_depcut(taga_obi_depcut>700) = 701;
% Get counts of each dataset within each bin
taga_jdi = histcounts(taga_jdi_depcut,edges);
taga_gbf = histcounts(taga_gbf_depcut,edges);
taga_obi = histcounts(taga_obi_depcut,edges);


f3 = figure(3)
leftcol = [0 0 0];
rightcol = [0 0 0];
set(f3,'defaultAxesColorOrder',[leftcol; rightcol]);
% JDI, GBF
b3 = bar(edges(1:end-1),[tspp_gbf;tspi_jdi;tspi_gbf;tspi_obi;taga_jdi;taga_gbf;taga_obi]',0.85);
ylim([0,6]);

for b = 1:length(b3)
    if b == 2
        b3(b).FaceColor = colsvec(2,:);
    elseif b == 3
        b3(b).FaceColor = colsvec(3,:);
    else
        b3(b).FaceColor = colsvec(4,:);
    end
end
hatchfill2(b3(1),'single','HatchAngle',-45,'hatchcolor',colsvec(2,:));
hatchfill2(b3(5),'single','HatchAngle',0,'hatchcolor',colsvec(1,:));
hatchfill2(b3(6),'single','HatchAngle',45,'hatchcolor',colsvec(2,:));
hatchfill2(b3(7),'cross','HatchAngle',45,'hatchcolor',colsvec(3,:));

set(gca,'TickDir','out','FontSize',18);
box off
yticks([0,2,4,6]);
yticklabels({'0','2','4','6'});
xticklabels({'0-100','100-200','200-300','300-400','400-500','500-600','600-700','>700'});
legend([b3(1),b3(2),b3(3),b3(4),b3(5),b3(6),b3(7)],...
    {'Pyrostremma spp. - GBIF (n=1)','Pr. spinosum - JeDI (n=2)','Pr. spinosum - GBIF (n=1)',...
    'Pr. spinosum - OBIS (n=2)','Pr. agassizi - JeDI (n=9)','Pr. agassizi - GBIF (n=4)',...
    'Pr. agassizi - OBIS (n=1)'},'FontSize',16);
hold off


% %% Histo #4: ALL Pyrosomella groups(Pyrosomella spp., Pl. verticillata)
% Pyrosomella spp. 
lspp_gbf_depcut = gbf_lspp_cln.Depth;
lspp_gbf_depcut(lspp_gbf_depcut>700) = 701;
lspp_obi_depcut = obi_lspp_cln.Depth_min;
lspp_obi_depcut(lspp_obi_depcut>700) = 701;
% Get counts of each dataset within each bin
lspp_gbf = histcounts(lspp_gbf_depcut,edges);
lspp_obi = histcounts(lspp_obi_depcut,edges);

% Pl. verticillata
lver_lit_depcut = lit_lver_cln.Depth_avg;
lver_lit_depcut(lver_lit_depcut>700) = 701;
lver_jdi_depcut = jdi_lver_cln.Depth_avg;
lver_jdi_depcut(lver_jdi_depcut>700) = 701;
lver_gbf_depcut = gbf_lver_cln.Depth;
lver_gbf_depcut(lver_gbf_depcut>700) = 701;
lver_obi_depcut = obi_lver_cln.Depth_min;
lver_obi_depcut(lver_obi_depcut>700) = 701;
% Get counts of each dataset within each bin
lver_lit = histcounts(lver_lit_depcut,edges);
lver_jdi = histcounts(lver_jdi_depcut,edges);
lver_gbf = histcounts(lver_gbf_depcut,edges);
lver_obi = histcounts(lver_obi_depcut,edges);
lver_emp = zeros(1,length(edges)-1); 

f4 = figure(4)
leftcol = [0 0 0];
rightcol = [0 0 0];
set(f4,'defaultAxesColorOrder',[leftcol; rightcol]);
% yyaxis left
b4 = bar(edges(1:end-1),[lspp_gbf;lspp_obi;lver_jdi;lver_gbf;lver_obi]',0.85);
ylim([0,8]);
for b = 1:length(b4)
    if b == 3
        b4(b).FaceColor = colsvec(2,:);
    elseif b == 4
        b4(b).FaceColor = colsvec(3,:);
    else
        b4(b).FaceColor = colsvec(4,:);
    end
end
hatchfill2(b4(1),'single','HatchAngle',45,'hatchcolor',colsvec(2,:));
hatchfill2(b4(2),'cross','HatchAngle',45,'hatchcolor',colsvec(3,:));

set(gca,'TickDir','out','FontSize',18);
box off
yticks([0,2,4,6,8]);
yticklabels({'0','2','4','6','8'});
xticklabels({'0-100','100-200','200-300','300-400','400-500','500-600','600-700','>700'});
legend([b4(1),b4(2),b4(3),b4(4),b4(5)],{'Pyrosomella spp. - GBIF (n=6)','Pyrosomella spp. - OBIS (n=1)',...
        'Pl. verticillata - JeDI (n=3)','Pl. verticillata - GBIF (n=6)',...
        'Pl. verticillata - OBIS (n=47)'},'FontSize',16);
hold off




% Histo #5: P. atlanticum - DVM
edge5 = [0,100,200,600];
lit_dvm = histcounts(lit_patl_cln.DVM,edge5);

f5 = figure(5)
b5 = bar(edge5(1:end-1),lit_dvm,0.3);
b5.FaceColor = [0 0 0];
ylim([0,7]);
set(gca,'TickDir','out','FontSize',18);
box off
xticklabels({'0-100','100-200','200-600'});
yticks([0,2,4,6]);
yticklabels({'0','2','4','6'});


