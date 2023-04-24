%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Codes for: 
%%%     Lilly et al. (in review). A Global Review of Pyrosomes:  
%%%     Shedding light on the ocean’s elusive gelatinous ‘fire-bodies’

% %% Step 5: Plot Fig. 1 from redundancy-removed DBs


%% ======= Fig. 1 - Map of global distributions ========
load coastlines

% %% FIG. 1 - COPEPOD, JeDI, GBIF, OBIS
% *Literature symbols added separately*
dispcolsf1 = [[255/255 180/255 195/255];[1 0.4 0.7];[1 0.8 0]; % Pyrosoma groups
              [0.6 0.2 0];[1 1 0];[1 0 0];
              [0.5 0 1];[0 1 1];[0 0 1]; % Pyrostremma groups
              % [0 1 1];[0.5 0 0.5] % OLD extra colors
              [0 0.4 0];[0 1 0]]; % Pyrosomella groups
edgecolsf1 = dispcolsf1-0.3;
edgecolsf1(edgecolsf1<0) = 0;
          
figure(1)
wh = worldmap('World')
setm(wh, 'MlabelParallel', 'south');
latp2 = [-50 50 50 -50];
lonp2 = [-180 -180 180 180];
setm(wh,'FontSize',14);
hold on
p1 = findobj(wh,'Tag','Parallel');
m1 = findobj(wh,'Tag','Meridian');
p1.LineStyle = '-';
m1.LineStyle = '-';
p1.LineWidth = 0.6;
m1.LineWidth = 0.6;
p1.Color = [0.3 0.3 0.3];
m1.Color = [0.3 0.3 0.3];
ch = plotm(coastlat,coastlon,'k');
psz = 20;

% 1.1. 'Pyrosoma spp.'
% 1.1.1. COPEPOD
plt_c_pspp= scatterm(cpd_pspp_cln.Lat_dec,cpd_pspp_cln.Lon_dec,psz,'o','filled','MarkerFaceColor',dispcolsf1(1,:),'MarkerEdgeColor',edgecolsf1(1,:));
plt_c_pspp= scatterm(cpd_pyra_pspp.Lat_dec,cpd_pyra_pspp.Lon_dec,psz,'o','filled','MarkerFaceColor',dispcolsf1(1,:),'MarkerEdgeColor','k');

% 1.1.2. JeDI
plt_j_pspp= scatterm(jdi_pspp_cln.Lat_dec,jdi_pspp_cln.Lon_dec,psz,'o','filled','MarkerFaceColor',dispcolsf1(2,:),'MarkerEdgeColor',edgecolsf1(2,:));
% 1.1.3. GBIF
plt_g_pspp= scatterm(gbf_pspp_cln.Lat_dec,gbf_pspp_cln.Lon_dec,psz,'o','filled','MarkerFaceColor',dispcolsf1(2,:),'MarkerEdgeColor','k');
% 1.1.4. OBIS
plt_o_pspp= scatterm(obi_pspp_cln.Lat_dec,obi_pspp_cln.Lon_dec,psz,'square','filled','MarkerFaceColor',dispcolsf1(2,:),'MarkerEdgeColor','k');

% 1.2. 'Pyrosoma atlanticum'
% 1.2.1. JeDI
plt_j_patl = scatterm(jdi_patl_cln.Lat_dec,jdi_patl_cln.Lon_dec,psz,'o','filled','MarkerFaceColor',dispcolsf1(3,:),'MarkerEdgeColor',edgecolsf1(3,:));
% 1.2.2. GBIF 
plt_g_patl = scatterm(gbf_patl_cln.Lat_dec,gbf_patl_cln.Lon_dec,psz,'o','filled','MarkerFaceColor',dispcolsf1(3,:),'MarkerEdgeColor','k');
% 1.2.3. OBIS 
plt_o_patl = scatterm(obi_patl_cln.Lat_dec,obi_patl_cln.Lon_dec,psz,'square','filled','MarkerFaceColor',dispcolsf1(3,:),'MarkerEdgeColor','k');

% % 1.3. 'Pyrosoma aherniosum'
% % 1.3.1. GBIF
% plt_g_pahe = scatterm(gbf_pahe_cln.Lat_dec,gbf_pahe_cln.Lon_dec,psz,'o','filled','MarkerFaceColor',dispcolsf1(4,:),'MarkerEdgeColor','k');
% 1.3.2. OBIS
plt_o_pahe = scatterm(obi_pahe_cln.Lat_dec,obi_pahe_cln.Lon_dec,psz,'square','filled','MarkerFaceColor',dispcolsf1(4,:),'MarkerEdgeColor','k');
 
% % 1.4. 'Pyrosoma godeauxi'
% % 1.4.1. GBIF
% plt_g_pgod = scatterm(gbf_pgod_cln.Lat_dec,gbf_pgod_cln.Lon_dec,psz,'o','filled','MarkerFaceColor',dispcolsf1(5,:),'MarkerEdgeColor','k');
% 
% % 1.5. 'Pyrosoma ovatum'
% % 1.5.1. GBIF
% plt_g_pova = scatterm(gbf_pova_cln.Lat_dec,gbf_pova_cln.Lon_dec,psz,'o','filled','MarkerFaceColor',dispcolsf1(6,:),'MarkerEdgeColor','k');
% 1.5.2. OBIS
plt_o_pova = scatterm(obi_pova_cln.Lat_dec,obi_pova_cln.Lon_dec,psz,'square','filled','MarkerFaceColor',dispcolsf1(6,:),'MarkerEdgeColor','k');

% 2.1. 'Pyrostremma spp.'
% 2.1.1. GBIF
plt_g_tspp = scatterm(gbf_tspp_cln.Lat_dec,gbf_tspp_cln.Lon_dec,psz,'o','filled','MarkerFaceColor',dispcolsf1(7,:),'MarkerEdgeColor','k');

% 2.2. 'Pyrostremma spinosum'
% 2.2.1. JeDI
plt_j_tspi = scatterm(jdi_tspi_cln.Lat_dec,jdi_tspi_cln.Lon_dec,psz,'o','filled','MarkerFaceColor',dispcolsf1(8,:),'MarkerEdgeColor',edgecolsf1(8,:));
% 2.2.2. GBIF
plt_g_tspi = scatterm(gbf_tspi_cln.Lat_dec,gbf_tspi_cln.Lon_dec,psz,'o','filled','MarkerFaceColor',dispcolsf1(8,:),'MarkerEdgeColor','k');
% 2.2.3. OBIS
plt_o_tspi = scatterm(obi_tspi_cln.Lat_dec,obi_tspi_cln.Lon_dec,psz,'square','filled','MarkerFaceColor',dispcolsf1(8,:),'MarkerEdgeColor','k');

% 2.3. 'Pyrostremma agassizi'
% 2.3.1. JeDI
plt_j_taga = scatterm(jdi_taga_cln.Lat_dec,jdi_taga_cln.Lon_dec,psz,'o','filled','MarkerFaceColor',dispcolsf1(9,:),'MarkerEdgeColor',edgecolsf1(9,:));
% 2.3.2. GBIF
plt_g_taga = scatterm(gbf_taga_cln.Lat_dec,gbf_taga_cln.Lon_dec,psz,'o','filled','MarkerFaceColor',dispcolsf1(9,:),'MarkerEdgeColor','k');
% 2.3.3. OBIS
plt_o_taga = scatterm(obi_taga_cln.Lat_dec,obi_taga_cln.Lon_dec,psz,'o','filled','MarkerFaceColor',dispcolsf1(9,:),'MarkerEdgeColor','k');

% 3.1. 'Pyrosomella spp.'
% 3.1.1. GBIF
plt_g_lspp = scatterm(gbf_lspp_cln.Lat_dec,gbf_lspp_cln.Lon_dec,psz,'o','filled','MarkerFaceColor',dispcolsf1(10,:),'MarkerEdgeColor','k');
% 3.1.2. OBIS
plt_o_lspp = scatterm(obi_lspp_cln.Lat_dec,obi_lspp_cln.Lon_dec,psz,'o','filled','MarkerFaceColor',dispcolsf1(10,:),'MarkerEdgeColor','k');

% 3.2. 'Pyrosomella verticillata'
% 3.2.1. JeDI
plt_j_lver = scatterm(jdi_lver_cln.Lat_dec,jdi_lver_cln.Lon_dec,psz,'o','filled','MarkerFaceColor',dispcolsf1(11,:),'MarkerEdgeColor',edgecolsf1(11,:));
% 3.2.2. GBIF
plt_g_lver = scatterm(gbf_lver_cln.Lat_dec,gbf_lver_cln.Lon_dec,psz,'o','filled','MarkerFaceColor',dispcolsf1(11,:),'MarkerEdgeColor','k');
% 3.2.3. OBIS
plt_o_lver = scatterm(obi_lver_cln.Lat_dec,obi_lver_cln.Lon_dec,psz,'square','filled','MarkerFaceColor',dispcolsf1(11,:),'MarkerEdgeColor','k');


% legend([plt_cpd;lgd_jd(1:2);lgd_jd(7:9)],{'Pyrosoma spp. - COPEPOD','Pyrosoma spp. - JeDI','P. atlanticum','Pr. agassizi','Pr. spinosum','Pl. verticillata'},'FontSize',10);
% legend boxoff


