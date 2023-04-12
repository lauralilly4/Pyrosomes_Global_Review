%%%%%%%%%%%%%%
%%% Codes for: 
%%%     Lilly et al. (in review). A Global Review of Pyrosomes:  
%%%     Shedding light on the ocean’s elusive gelatinous ‘fire-bodies’

% %% Part 1: Load all datasets; separate into arrays by species/group



%% ======= Step 1: Load database files =======
% Pyrosome Databases
cpdfl = readtable('NOAA_COPEPOD_Urochordates.txt');
jdifl = load('BCO_DMO_JeDI_Jellies.mat');
obsfl = readtable('LiteratureStudies_PyrosomeObs_DensityDepth.csv');
obsflal = readtable('LiteratureStudies_PyrosomeObs_All.csv');
gbif_pyra_fl = readtable('GBIF_Pyrosoma_records.txt');
gbif_pyrl_fl = readtable('GBIF_Pyrosomella_records.txt');
gbif_pyrt_fl = readtable('GBIF_Pyrostremma_records.txt');
% Physical variables
t0nm = 'NOAA_OISST_longtermmean_1981_2010.nc';
chl1nm = 'GMIS_A_CHLA_01.nc';
chl2nm = 'GMIS_A_CHLA_02.nc';
chl3nm = 'GMIS_A_CHLA_03.nc';
chl4nm = 'GMIS_A_CHLA_04.nc';
chl5nm = 'GMIS_A_CHLA_05.nc';
chl6nm = 'GMIS_A_CHLA_06.nc';
chl7nm = 'GMIS_A_CHLA_07.nc';
chl8nm = 'GMIS_A_CHLA_08.nc';
chl9nm = 'GMIS_A_CHLA_09.nc';
chl10nm = 'GMIS_A_CHLA_10.nc';
chl11nm = 'GMIS_A_CHLA_11.nc';
chl12nm = 'GMIS_A_CHLA_12.nc';


%% ======= Step 2a: COPEPOD - 'Pyrosome' entries =======
% Filter table for only rows of 'Pyrosomatidae' or 'Pyrosoma parts/fragments'
cpd_pyro = cpdfl(cpdfl.SCIENTIFIC_NAME == "Pyrosomatidae -[ ]-",:); % Filter table for only rows of 'Pyrosomatidae'
cpd_pyropts = cpdfl(cpdfl.SCIENTIFIC_NAME == "Pyrosoma parts/fragments -[ ]-",:);

cpd_pyro_zro = cpd_pyro(str2double(cpd_pyro.VALUE_per_volu) == 0,:);
cpd_pyro_nnzro = cpd_pyro(str2double(cpd_pyro.VALUE_per_volu) > 0,:);
cpd_pyro_nnzroabd = str2double(cpd_pyro_nnzro.VALUE_per_volu); %no./m3

% COPEPOD entries at < 50S
cpd50all = cpd_pyro_nnzro((cpd_pyro_nnzro.LATITUDE < -50),:);
cpd50prj = cpd_pyro_nnzro.PROJ((cpd_pyro_nnzro.LATITUDE < -50),:);
cpd50rid = cpd_pyro_nnzro.RECORD_ID((cpd_pyro_nnzro.LATITUDE < -50),:); % Record ID
cpd50did = cpd_pyro_nnzro.DATASET_ID((cpd_pyro_nnzro.LATITUDE < -50),:); % Dataset ID



%% ======= Step 2b: JeDI =======
% Build table from struct (have to flip around some variables)
jdi_tbl = table(jdifl.project_title,jdifl.sub_project_title,jdifl.owner_dataset,jdifl.location_name, ...
                jdifl.year',jdifl.month,jdifl.day',jdifl.lat',jdifl.lon',jdifl.taxon, ...
                jdifl.rank_phylum,jdifl.rank_genus,jdifl.rank_species,jdifl.depth,jdifl.depth_upper, ...
                jdifl.depth_lower,jdifl.density,jdifl.density_integrated,jdifl.biovolume, ...
                jdifl.biovolume_integrated,jdifl.weight_wet,jdifl.weight_dry,jdifl.presence_absence,jdifl.accompanying_ancillary_data); 
                    
jdi_tbl.Properties.VariableNames(:) = {'Proj_Title','Sub_Proj_Title','Owner_dataset','Location', ...
                                    'Year' 'Month' 'Day' 'Lat' 'Lon' 'Taxon' 'Rank_Phylum' 'Rank_Genus' 'Rank_Species' ...
                                    'Depth' 'Depth_upper' 'Depth_lower' 'Density' 'Density_int' 'Biovol' ...
                                    'Biovol_int' 'WW' 'DW' 'Pres_Abs' 'Habitat_data'};

% Get the unique 'Genus' name and select 'Pyrosoma' (to get exact string format)                                                                       
genus_unq = unique(jdi_tbl.Rank_Genus,'rows');                  
genus_pyro = genus_unq(239,:); % 'Pyrosoma' string name
genuscomp = strcmp(genus_unq,genus_pyro);

% Get indices of all 'Genus' entries that match 'Pyrosoma'
jdipyromtch = [];
for c=1:height(jdi_tbl)
    jdicmp = strcmp(jdi_tbl.Rank_Genus(c,:),genus_pyro); 
    jdipyromtch = [jdipyromtch;jdicmp];
end
jdipyroidx = find(jdipyromtch == 1);


% %% JeDI PYROS ARRAY %%
% 1) Subset of table rows for 'Genus = Pyrosoma'                     
jdi_pyro_sub = jdi_tbl(jdipyroidx,:);

% 2) Convert 'char'-type (cell) variables -> numeric
jdi_pyro_mon = str2double(cellstr(jdi_pyro_sub.Month));
jdi_pyro_dep = str2double(cellstr(jdi_pyro_sub.Depth));
jdi_pyro_depup = str2double(cellstr(jdi_pyro_sub.Depth_upper));
jdi_pyro_deplw = str2double(cellstr(jdi_pyro_sub.Depth_lower));
jdi_pyro_dens = str2double(cellstr(jdi_pyro_sub.Density));
jdi_pyro_densint = str2double(cellstr(jdi_pyro_sub.Density_int));
jdi_pyro_bivl = str2double(cellstr(jdi_pyro_sub.Biovol));
jdi_pyro_bivlint = str2double(cellstr(jdi_pyro_sub.Biovol_int));

% %%% DEPTH-AVERAGING %%%
% Get a merged/averaged vector from Depth, Depth_upper, and Depth_lower ->
% to get *some* depth for each entry
jdi_pyro_depavg = nanmean([jdi_pyro_dep,jdi_pyro_depup,jdi_pyro_deplw],2);


% 3) Recombine table with new (numeric) variables 
jdi_pyro_arr = [jdi_pyro_sub(:,1:5),table(jdi_pyro_mon),jdi_pyro_sub(:,7:13),...
                table(jdi_pyro_depavg),table(jdi_pyro_dens),table(jdi_pyro_densint),...
                table(jdi_pyro_bivl),table(jdi_pyro_bivlint),jdi_pyro_sub(:,21:end)];
jdi_pyro_arr.Properties.VariableNames = cat(1,[jdi_tbl.Properties.VariableNames{1:13},{'Depth_avg'},jdi_tbl.Properties.VariableNames(17:end)]);


% %%% DEPTH INDICES %%%
% Get counts of: no. records > 1000 m, no. records <= 1000m
jdi_shlw_idx = find(jdi_pyro_arr.Depth_avg <= 700);
jdi_deep_idx = find(jdi_pyro_arr.Depth_avg > 700);


% %%% PRESENCE/ABSENCE %%%
jdi_pyro_prsidx = [];
jdi_pyro_absidx = [];

for j=1:height(jdi_pyro_arr)
    if strcmp(jdi_pyro_arr.Pres_Abs(j,:),'present') == 1
        jdi_pyro_prsidx = [jdi_pyro_prsidx; j];
    elseif strcmp(jdi_pyro_arr.Pres_Abs(j,:),jdi_pyro_arr.Pres_Abs(862,:)) == 1
        jdi_pyro_absidx = [jdi_pyro_absidx; j];
    else
        keyboard
    end   
end

% Get Pres' and 'Abs' 
jdipyroprs = jdi_pyro_arr(jdi_pyro_prsidx,:);
jdipyroabs = jdi_pyro_arr(jdi_pyro_absidx,:);


% %%% COUNT OF SOUTHERN LATITUDES (>50oS) %%%
jdi50all = jdipyroprs((jdipyroprs.Lat < -50),:);
jdi50prj = jdipyroprs.Proj_Title((jdipyroprs.Lat < -50),:);
jdi50own = jdipyroprs.Owner_dataset((jdipyroprs.Lat < -50),:);
    
            

%% ======= Step 2c: Observations file =======
% %% *Density* observations
obsdns = obsfl(~isnan(obsfl.Density_lower_col_m3) | ~isnan(obsfl.Density_upper_col_m3),:);
lowidx = find(~isnan(obsdns.Density_lower_col_m3));
uppidx = find(~isnan(obsdns.Density_upper_col_m3));
txtidxpac = [5];
txtidxatl = [1,3,10,12];
txtidxind = [9,11];

% %% *Depth* observations
% Pelagic
obsdepplg = obsfl(~isnan(obsfl.Depth_mid_day) | ~isnan(obsfl.Depth_mid_night) | ~isnan(obsfl.Depth_mid_notime),:);
obsdepplg_dynot = nanmean([obsdepplg.Depth_mid_day,obsdepplg.Depth_mid_notime],2);

% Calculate DVM values
idx_dvm = find(~isnan(obsdepplg.Depth_mid_day-obsdepplg.Depth_mid_night));
obsdep_dvm = obsdepplg(idx_dvm,:);

% Remove duplicate points and shift over 2nd Drits et al. 
[~,idxdvmunq] = ismember(unique(string(obsdep_dvm.Map_key)),string(obsdep_dvm.Map_key));
obsdep_dvmunq = [obsdep_dvm(2,:);obsdep_dvm(idxdvmunq,:)];
obsdep_dvmunq{1,9} = obsdep_dvmunq{1,9}+3;
obsdep_dvmunq.Map_key(1) = {''};
obsdvm = obsdep_dvmunq.Depth_mid_day-obsdep_dvmunq.Depth_mid_night;

% *Benthic* observations
obsdepbnt = obsfl(~isnan(obsfl.Depth_min_benth) | ~isnan(obsfl.Depth_max_benth),:);



%% ======= Step 2d: GBIF Database =======
% For three Genus files ('Pyrosoma','Pyrosomella','Pyrostremma')
% d.1) Partition 'eventDate' into 'Y','M','D'
% Get length of 'filled' date cell --> to know how long to make 'NaN' cells
% for dates
celllen = length(cell2mat(gbif_pyra_fl.eventDate(5)));

% %% Pyrosoma
% Convert 'Dates' & Lat/Lon cells to character array to extract Y,M,D components
gbifdtcell_r = gbif_pyra_fl.eventDate;
gbifdtempty_r = cellfun('isempty',gbifdtcell_r);
gbifdtcell_r(gbifdtempty_r) = {'9999999999999999999'};
gbifdtarr_r = cell2mat(gbifdtcell_r);

% Then convert Date components, Lat, and Lon -> back to numerics
gbifyr_r = str2num(gbifdtarr_r(:,1:4));
gbifmo_r = str2num(gbifdtarr_r(:,6:7));
gbifdy_r = str2num(gbifdtarr_r(:,9:10));
gbiflat_r = str2double(cellstr(gbif_pyra_fl.decimalLatitude));
gbiflon_r = str2double(cellstr(gbif_pyra_fl.decimalLongitude));

% gbiflatarr_r = [];
% for a = 1:height(gbif_pyra_fl)
%     if isempty(gbif_pyra_fl.decimalLatitude{a})
%         latrim = NaN;
%     elseif length(gbif_pyra_fl.decimalLatitude{a}) < 4
%         latrim = str2num(gbif_pyra_fl.decimalLatitude{a});
%     else
%         latrim = str2num(gbif_pyra_fl.decimalLatitude{a}(1:4));
%     end
%     gbiflatarr_r = [gbiflatarr_r;latrim];
% end
% % Longitude -> to numbers
% gbiflonarr_r = [];
% for o = 1:height(gbif_pyra_fl)
%     if isempty(gbif_pyra_fl.decimalLongitude{o})
%         lotrim = NaN;
%     elseif length(gbif_pyra_fl.decimalLongitude{o}) < 5
%         lotrim = str2num(gbif_pyra_fl.decimalLongitude{o});
%     else
%         lotrim = str2num(gbif_pyra_fl.decimalLongitude{o}(1:5));
%     end
%     gbiflonarr_r = [gbiflonarr_r;lotrim];
% end

% Recombine selected variables from GBIF into subset table
gbiftbl_r = table(gbif_pyra_fl.gbifID,gbif_pyra_fl.institutionID,gbif_pyra_fl.datasetID,...
            gbif_pyra_fl.year,gbifyr_r,gbifmo_r,gbifdy_r,gbiflat_r,...
            gbiflon_r,gbif_pyra_fl.scientificName,gbif_pyra_fl.phylum,...
            gbif_pyra_fl.class,gbif_pyra_fl.order,gbif_pyra_fl.family,gbif_pyra_fl.subfamily,...
            gbif_pyra_fl.genus,gbif_pyra_fl.depth,gbif_pyra_fl.verbatimScientificName);

gbiftbl_r.Properties.VariableNames(:) = {'GBIF_ID','Institution_ID','Dataset_ID','Year_rec',...
                                        'Year_date','Mon_date','Day_date','Lat_dec','Lon_dec',...
                                        'Scientific_name','Phylum','Class','Order','Family',...
                                        'Subfamily','Genus','Depth','Sci_name_verbatim'};  
                                    
                                   
% %% Pyrostremma
gbifdtcell_t = gbif_pyrt_fl.eventDate;
gbifdtempty_t = cellfun('isempty',gbifdtcell_t);
gbifdtcell_t(gbifdtempty_t) = {'9999999999999999999'};
gbifdtarr_t = cell2mat(gbifdtcell_t);
% Convert Date components -> numeric
gbifyr_t = str2num(gbifdtarr_t(:,1:4));
gbifmo_t = str2num(gbifdtarr_t(:,6:7));
gbifdy_t = str2num(gbifdtarr_t(:,9:10));

% Recombine selected variables from GBIF into subset table                                   
gbiftbl_t = table(gbif_pyrt_fl.gbifID,gbif_pyrt_fl.institutionID,gbif_pyrt_fl.datasetID,...
        gbif_pyrt_fl.year,gbifyr_t,gbifmo_t,gbifdy_t,gbif_pyrt_fl.decimalLatitude,...
        gbif_pyrt_fl.decimalLongitude,gbif_pyrt_fl.scientificName,gbif_pyrt_fl.phylum,...
        gbif_pyrt_fl.class,gbif_pyrt_fl.order,gbif_pyrt_fl.family,gbif_pyrt_fl.subfamily,...
        gbif_pyrt_fl.genus,gbif_pyrt_fl.depth,gbif_pyrt_fl.verbatimScientificName);

gbiftbl_t.Properties.VariableNames(:) = {'GBIF_ID','Institution_ID','Dataset_ID','Year_rec',...
                                        'Year_date','Mon_date','Day_date','Lat_dec','Lon_dec',...
                                        'Scientific_name','Phylum','Class','Order','Family',...
                                        'Subfamily','Genus','Depth','Sci_name_verbatim'};
 
                                    
% Pyrosomella
gbifdtcell_l = gbif_pyrl_fl.eventDate;
gbifdtempty_l = cellfun('isempty',gbifdtcell_l);
gbifdtcell_l(gbifdtempty_l) = {'9999999999999999999'};
gbifdtarr_l = cell2mat(gbifdtcell_l);
% Convert Date components -> numeric
gbifyr_l = str2num(gbifdtarr_l(:,1:4));
gbifmo_l = str2num(gbifdtarr_l(:,6:7));
gbifdy_l = str2num(gbifdtarr_l(:,9:10));

% Recombine selected variables from GBIF into subset table                               
gbiftbl_l = table(gbif_pyrl_fl.gbifID,gbif_pyrl_fl.institutionID,gbif_pyrl_fl.datasetID,...
        gbif_pyrl_fl.year,gbifyr_l,gbifmo_l,gbifdy_l,gbif_pyrl_fl.decimalLatitude,...
        gbif_pyrl_fl.decimalLongitude,gbif_pyrl_fl.scientificName,gbif_pyrl_fl.phylum,...
        gbif_pyrl_fl.class,gbif_pyrl_fl.order,gbif_pyrl_fl.family,gbif_pyrl_fl.subfamily,...
        gbif_pyrl_fl.genus,gbif_pyrl_fl.depth,gbif_pyrl_fl.verbatimScientificName);

gbiftbl_l.Properties.VariableNames(:) = {'GBIF_ID','Institution_ID','Dataset_ID','Year_rec',...
                                        'Year_date','Mon_date','Day_date','Lat_dec','Lon_dec',...
                                        'Scientific_name','Phylum','Class','Order','Family',...
                                        'Subfamily','Genus','Depth','Sci_name_verbatim'};
                   
                                    