%%%%%%%%%%%%%%
%%% Codes for: 
%%%     Lilly et al. (in review). A Global Review of Pyrosomes:  
%%%     Shedding light on the ocean’s elusive gelatinous ‘fire-bodies’

% %% Part 1: Load pyrosome datasets as tables and make adjustments



%% ======= Step 1: Load database files =======
% Pyrosome Databases
litfl = readtable('LiteratureStudies_PyrosomeObs_All.csv');
cpdfl = readtable('NOAA_COPEPOD_Urochordates.txt');
jdifl = readtable('JeDI_Pyro_All.csv');
gbffl_r = readtable('GBIF_Pyrosoma.csv');
gbffl_t = readtable('GBIF_Pyrostremma.csv');
gbffl_l = readtable('GBIF_Pyrosomella.csv');
obifl = readtable('OBIS_Pyro_All.csv');


%% ======= tep 2a: Unpack files - Literature =======
% %% *Density* records only
lit_pyro_dns = litfl(~isnan(litfl.Density_lower_col_m3) | ~isnan(litfl.Density_upper_col_m3),:);
lowidx = find(~isnan(lit_pyro_dns.Density_lower_col_m3));
uppidx = find(~isnan(lit_pyro_dns.Density_upper_col_m3));


% %% Can't remember what these do
% txtidxpac = [5];
% txtidxatl = [1,3,10,12];
% txtidxind = [9,11];

% %% Get *average Depth* (from '_day' and '_notime') 
% lit_pyro_dep = litfl(~isnan(litfl.Depth_mid_day) | ~isnan(litfl.Depth_mid_night) | ~isnan(litfl.Depth_mid_notime),:);
litdep_avgdy = nanmean([litfl.Depth_mid_day,litfl.Depth_mid_notime],2);
% Calculate DVM values
% idx_dvm = find(~isnan(litfl.Depth_mid_day-litfl.Depth_mid_night));
% litdep_dvm = lit_pyro_dep(idx_dvm,:);
litdep_dvm = litfl.Depth_mid_day-litfl.Depth_mid_night;


% %% RECOMBINE file with new variables ('Depth_avg' and 'DVM')
lit_pyro_all = [litfl,table(litdep_avgdy),table(litdep_dvm)];
lit_pyro_all.Properties.VariableNames(5) = {'Year'};
lit_pyro_all.Properties.VariableNames(6) = {'Month'};
lit_pyro_all.Properties.VariableNames(7) = {'Lat_dec'};
lit_pyro_all.Properties.VariableNames(8) = {'Lon_dec'};
lit_pyro_all.Properties.VariableNames(16) = {'Depth_avg'};
lit_pyro_all.Properties.VariableNames(17) = {'DVM'};


% % Remove duplicate points and shift over 2nd Drits et al. 
% [~,idxdvmunq] = ismember(unique(string(litdep_dvm.Map_key)),string(litdep_dvm.Map_key));
% litdep_dvmunq = [litdep_dvm(2,:);litdep_dvm(idxdvmunq,:)];
% litdep_dvmunq{1,9} = litdep_dvmunq{1,9}+3;
% litdep_dvmunq.Map_key(1) = {''};
% litdvm = litdep_dvmunq.Depth_mid_day-litdep_dvmunq.Depth_mid_night;

% %% *Benthic* observations - literature
litdepbnt = litfl(~isnan(litfl.Depth_min_benth) | ~isnan(litfl.Depth_max_benth),:);


%% ======= Step 2b: Unpack files - COPEPOD =======
% Filter table for only rows of 'Pyrosomatidae' or 'Pyrosoma parts/fragments'
cpd_pyro = cpdfl(cpdfl.SCIENTIFIC_NAME == "Pyrosomatidae -[ ]-",:); % Filter table for only rows of 'Pyrosomatidae'
cpd_pyropts = cpdfl(cpdfl.SCIENTIFIC_NAME == "Pyrosoma parts/fragments -[ ]-",:);

% %% ***TABLE: ALL COPEPOD Pyros subset***
cpd_pyra_pspp = cpd_pyro(str2double(cpd_pyro.VALUE_per_volu) > 0,:);
cpd_pyra_pspp.Properties.VariableNames(2) = {'Year'};
cpd_pyra_pspp.Properties.VariableNames(3) = {'Month'};
cpd_pyra_pspp.Properties.VariableNames(4) = {'Day'};
cpd_pyra_pspp.Properties.VariableNames(7) = {'Lat_dec'};
cpd_pyra_pspp.Properties.VariableNames(8) = {'Lon_dec'};

% %% Table of *ZERO* pyrosome values (absence) -> to show relative
% distributions of 'Presence' against 'Total Sampling'
cpd_pyro_zro = cpd_pyro(str2double(cpd_pyro.VALUE_per_volu) == 0,:);
% %% Get *abundance* values for non-zero points
cpd_pyro_nnzroabd = str2double(cpd_pyra_pspp.VALUE_per_volu); %no./m3
% %% COPEPOD entries at < 50S
cpd50all = cpd_pyra_pspp((cpd_pyra_pspp.Lat_dec < -50),:);
cpd50prj = cpd_pyra_pspp.PROJ((cpd_pyra_pspp.Lat_dec < -50),:);
cpd50rid = cpd_pyra_pspp.RECORD_ID((cpd_pyra_pspp.Lat_dec < -50),:); % Record ID
cpd50did = cpd_pyra_pspp.DATASET_ID((cpd_pyra_pspp.Lat_dec < -50),:); % Dataset ID


%% ======= Step 2c: Unpack files - JeDI =======
% %% Step 1: Get a merged/averaged vector from Depth, Depth_upper, and Depth_lower ->
% to get *some* depth for each entry
jdi_pyro_depavg = nanmean([jdifl.Depth,jdifl.Depth_upper,jdifl.Depth_lower],2);

% %% Step 2: Recombine table with averaged Depth variable
jdi_pyro_arr = [jdifl(:,1:13),table(jdi_pyro_depavg),jdifl(:,17:24)];
jdi_pyro_arr.Properties.VariableNames = cat(1,[jdifl.Properties.VariableNames{1:7},{'Lat_dec'},{'Lon_dec'},...
                                               jdifl.Properties.VariableNames{10:13},{'Depth_avg'},...
                                               jdifl.Properties.VariableNames(17:end)]);


% %% EXTRA
% %% Depth Indices
% Get counts of: no. records > 1000 m, no. records <= 1000m
jdi_shlw_idx = find(jdi_pyro_arr.Depth_avg <= 700);
jdi_deep_idx = find(jdi_pyro_arr.Depth_avg > 700);

% %%% Presence/Absence
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

% %%% Counts of Southern Ocean (>50oS)
jdi50all = jdipyroprs((jdipyroprs.Lat_dec < -50),:);
jdi50prj = jdipyroprs.Proj_Title((jdipyroprs.Lat_dec < -50),:);
jdi50own = jdipyroprs.Owner_dataset((jdipyroprs.Lat_dec < -50),:);


%% ======= Step 2d: Unpack files - GBIF =======
gbiftbl_r = gbffl_r;
gbiftbl_r.Properties.VariableNames = cat(1,[gbiftbl_r.Properties.VariableNames{1:4},{'Year'},{'Month'},...
                                               {'Day'},gbiftbl_r.Properties.VariableNames(8:end)]);
gbiftbl_t = gbffl_t;
gbiftbl_t.Properties.VariableNames = cat(1,[gbiftbl_t.Properties.VariableNames{1:4},{'Year'},{'Month'},...
                                               {'Day'},gbiftbl_t.Properties.VariableNames(8:end)]);
gbiftbl_l = gbffl_l;
gbiftbl_l.Properties.VariableNames = cat(1,[gbiftbl_l.Properties.VariableNames{1:4},{'Year'},{'Month'},...
                                               {'Day'},gbiftbl_l.Properties.VariableNames(8:end)]);


%% ======= Step 2e: Unpack files - OBIS =======
obitbl = obifl;
