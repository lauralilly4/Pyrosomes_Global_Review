%%%%%%%%%%%%%%
%%% Codes for: 
%%%     Lilly et al. (in review). A Global Review of Pyrosomes:  
%%%     Shedding light on the ocean’s elusive gelatinous ‘fire-bodies’

% %% Part 3: Remove duplicate records: 
%       i) from overlapping databases
%       ii) within each individual databases



%% ======= Step 1: Remove duplicate samples from multiple datasets ========  
% For each species group that had records in 2+ databases, we compared
% those databases for records with the same: date, lat, and lon, ordered
% as:
%       1) Same Lat & Lon (each to within 0.1 deg)?  If so,
%       2) same date (MMM-YYYY)?
% For duplicate records, we kept them in the database as: 
% i) COPEPOD (i.e., all repeat records that exist in COPEPOD we kept only
% in that one), then ii) JeDI (repeat records only between JeDI and GBIF),
% then 3) GBIF (i.e., records only in GBIF).


% %%%%%% 1.1. Pyrosoma spp. - Pt. 1 (COPE & JeDI) %%%%%% 
% Primary ('keep') array: COPEPOD
% Secondary ('discard') array: JeDI
% 0: Add column of 'row numbers' to "overall" 'patl_array' to keep track
% for eventual index removal
jdi_pspp_ids = [jdi_pspp table((1:1:height(jdi_pspp))')];
jdi_pspp_ids.Properties.VariableNames([end]) = {'Arr_RowNum'};

% 1a: First, find LAT & LON duplicates between GBIF and JeDI
latids_cpd_ps = [];
latids_jdi_ps = [];
for j=1:height(cpd_pyro_nnzro)
    for g=1:height(jdi_pspp_ids)
        cmp = abs(cpd_pyro_nnzro.LATITUDE(j)-jdi_pspp_ids.Lat(g));
        if cmp <= 0.1
            latids_cpd_ps = [latids_cpd_ps;j];
            latids_jdi_ps = [latids_jdi_ps;g];
        end
    end
end
lonids_cpd_ps = [];
lonids_jdi_ps = [];
for j=1:height(cpd_pyro_nnzro)
    for g=1:height(jdi_pspp_ids)
        cmp = abs(cpd_pyro_nnzro.LONGITDE(j)-jdi_pspp_ids.Lon(g));
        if cmp <= 0.1
            lonids_cpd_ps = [lonids_cpd_ps;j];
            lonids_jdi_ps = [lonids_jdi_ps;g];
        end
    end
end

% 1b: Assess which LAT & LON indices overlap --> to get subset of indices 
% that contain *both* Lat and Lon overlap (i.e., not just Lat OR Lon)
idscpdps = intersect(latids_cpd_ps,lonids_cpd_ps);
idsjdips = intersect(latids_jdi_ps,lonids_jdi_ps);

% 2a: for subset of Lat/Lon matchups, find DATE (MM-YYY) overlaps
cpd_pspp_lalosub = cpd_pyro_nnzro(idscpdps,:);
jdi_pspp_lalosub = jdi_pspp_ids(idsjdips,:);

% 2b: Check additional match-up of Lats/Lons via *Dates*
jdi_pspp_dtids = [];
for x = 1:height(cpd_pspp_lalosub)
    % First, get the GBIF indices that match each *individual* JeDI Lat &
    % Lon (have to "re-go-through" the subset of all matched idxs (same as
    % Step 1 above, but just for ONE JeDI Lat & Lon)
    latidx = find(abs(jdi_pspp_lalosub.Lat-cpd_pspp_lalosub.LATITUDE(x)) <= 0.1);
    lonidx = find(abs(jdi_pspp_lalosub.Lon-cpd_pspp_lalosub.LONGITDE(x)) <= 0.1);
    idxint = intersect(latidx,lonidx);  
    subarr = jdi_pspp_lalosub(idxint,:);
    
    if isempty(subarr)
        continue
    else
        % Then get indices of Year and Mon matchups (from Date components)
        [~,yrint] = ismember(subarr.Year,cpd_pspp_lalosub.YEAR(x));
        [~,moint] = ismember(subarr.Month,cpd_pspp_lalosub.MON(x));
        dtint = ismember(yrint,moint);
        gbf_ids = find(dtint == 1);
        dtidx = idxint(gbf_ids);
    end
    
    if isempty(dtint)
        continue
    else
        jdi_pspp_dtids = [jdi_pspp_dtids;dtidx];
    end 
end

% 2c: Use subset index values to get 'Arr_RowNum' index values from larger
% 'gbf_patl' array --> to remove the correct rows from the *overall* array
jdi_pspp_rmids = jdi_pspp_lalosub.Arr_RowNum(jdi_pspp_dtids);
jdi_pspp_cut = jdi_pspp;
jdi_pspp_cut(jdi_pspp_rmids,:) = []; % NEW subset array with duplicates (with other DB) removed



% %%%%%% 1.2. Pyrosoma spp. - Pt. 2 (COPE & GBIF) %%%%%% 
% Primary ('keep') array: COPEPOD
% Secondary ('discard') array: GBIF
% 0: Add column of 'row numbers' to "overall" 'patl_array' to keep track
% for eventual index removal
gbf_pspp_ids = [gbf_pyra_pspp table((1:1:height(gbf_pyra_pspp))')];
gbf_pspp_ids.Properties.VariableNames([end]) = {'Arr_RowNum'};

% 1a: First, find LAT & LON duplicates
latids_cpd2_ps = [];
latids_gbf_ps = [];
for j=1:height(cpd_pyro_nnzro)
    for g=1:height(gbf_pspp_ids)
        cmp = abs(cpd_pyro_nnzro.LATITUDE(j)-gbf_pspp_ids.Lat_dec(g));
        if cmp <= 0.1
            latids_cpd2_ps = [latids_cpd2_ps;j];
            latids_gbf_ps = [latids_gbf_ps;g];
        end
    end
end
lonids_cpd2_ps = [];
lonids_gbf_ps = [];
for j=1:height(cpd_pyro_nnzro)
    for g=1:height(gbf_pspp_ids)
        cmp = abs(cpd_pyro_nnzro.LONGITDE(j)-gbf_pspp_ids.Lon_dec(g));
        if cmp <= 0.1
            lonids_cpd2_ps = [lonids_cpd2_ps;j];
            lonids_gbf_ps = [lonids_gbf_ps;g];
        end
    end
end

% 1b: Assess which LAT & LON indices overlap --> to get subset of indices 
% that contain *both* Lat and Lon overlap (i.e., not just Lat OR Lon)
idscpdps2 = intersect(latids_cpd2_ps,lonids_cpd2_ps);
idsgbfps = intersect(latids_gbf_ps,lonids_gbf_ps);

% 2a: for subset of Lat/Lon matchups, find DATE (MM-YYY) overlaps
cpd_pspp_lalosub = cpd_pyro_nnzro(idscpdps2,:);
gbf_pspp_lalosub = gbf_pspp_ids(idsgbfps,:);

% 2b: Check additional match-up of Lats/Lons via *Dates*
gbf_pspp_dtids = [];
for x = 1:height(cpd_pspp_lalosub)
    % First, get the GBIF indices that match each *individual* JeDI Lat &
    % Lon (have to "re-go-through" the subset of all matched idxs (same as
    % Step 1 above, but just for ONE JeDI Lat & Lon)
    latidx = find(abs(gbf_pspp_lalosub.Lat_dec-cpd_pspp_lalosub.LATITUDE(x)) <= 0.1);
    lonidx = find(abs(gbf_pspp_lalosub.Lon_dec-cpd_pspp_lalosub.LONGITDE(x)) <= 0.1);
    idxint = intersect(latidx,lonidx);                
    subarr = gbf_pspp_lalosub(idxint,:);
    
    if isempty(subarr)
        continue
    else
        % Then get indices of Year and Mon matchups (from Date components)
        [~,yrint] = ismember(subarr.Year_date,cpd_pspp_lalosub.YEAR(x));
        [~,moint] = ismember(subarr.Mon_date,cpd_pspp_lalosub.MON(x));
        dtint = ismember(yrint,moint);
        gbf_ids = find(dtint == 1); % Retain ALL indices of matchup to single JeDI value
        dtidx = idxint(gbf_ids);
    end
    
    if isempty(dtint)
        continue
    else
        gbf_pspp_dtids = [gbf_pspp_dtids;dtidx];
    end 
end

% 2c: Use subset index values to get 'Arr_RowNum' index values from larger
% 'gbf_patl' array --> to remove the correct rows from the *overall* array
gbf_pspp_rmids = gbf_pspp_lalosub.Arr_RowNum(gbf_pspp_dtids);
gbf_pspp_cuta = gbf_pyra_pspp;
gbf_pspp_cuta(gbf_pspp_rmids,:) = []; % NEW subset array with duplicates (with other DB) removed



% %%%%%% 1.3. Pyrosoma spp. - Pt. 3 (JeDI & GBIF) %%%%%% 
% --> From both *subsets*
% Primary ('keep') array: JeDI
% Secondary ('discard') array: GBIF
% 0: Add column of 'row numbers' to "overall" 'patl_array' to keep track
% for eventual index removal
gbf_pspp_idsb = [gbf_pspp_cuta table((1:1:height(gbf_pspp_cuta))')];
gbf_pspp_idsb.Properties.VariableNames([end]) = {'Arr_RowNum'};

% 1a: First, find LAT & LON duplicates between GBIF and JeDI
latids_jdi_psb = [];
latids_gbf_psb = [];
for j=1:height(jdi_pspp_cut)
    for g=1:height(gbf_pspp_idsb)
        cmp = abs(jdi_pspp_cut.Lat(j)-gbf_pspp_idsb.Lat_dec(g));
        if cmp <= 0.1
            latids_jdi_psb = [latids_jdi_psb;j];
            latids_gbf_psb = [latids_gbf_psb;g];
        end
    end
end
lonids_jdi_psb = [];
lonids_gbf_psb = [];
for j=1:height(jdi_pspp_cut)
    for g=1:height(gbf_pspp_idsb)
        cmp = abs(jdi_pspp_cut.Lon(j)-gbf_pspp_idsb.Lon_dec(g));
        if cmp <= 0.1
            lonids_jdi_psb = [lonids_jdi_psb;j];
            lonids_gbf_psb = [lonids_gbf_psb;g];
        end
    end
end

% 1b: Assess which LAT & LON indices overlap --> to get subset of indices 
% that contain *both* Lat and Lon overlap (i.e., not just Lat OR Lon)
idsjdipsb = intersect(latids_jdi_psb,lonids_jdi_psb);
idsgbfpsb = intersect(latids_gbf_psb,lonids_gbf_psb);

% 2a: for subset of Lat/Lon matchups, find DATE (MM-YYY) overlaps
jdi_psppb_lalosub = jdi_pspp_cut(idsjdipsb,:);
gbf_psppb_lalosub = gbf_pspp_idsb(idsgbfpsb,:);

% 2b: Check additional match-up of Lats/Lons via *Dates*
gbf_psppb_dtids = [];
for x = 1:height(jdi_psppb_lalosub)
    % First, get the GBIF indices that match each *individual* JeDI Lat &
    % Lon (have to "re-go-through" the subset of all matched idxs (same as
    % Step 1 above, but just for ONE JeDI Lat & Lon)
    latidx = find(abs(gbf_psppb_lalosub.Lat_dec-jdi_psppb_lalosub.Lat(x)) <= 0.1);
    lonidx = find(abs(gbf_psppb_lalosub.Lon_dec-jdi_psppb_lalosub.Lon(x)) <= 0.1);
    idxint = intersect(latidx,lonidx);                
    subarr = gbf_psppb_lalosub(idxint,:);
    
    if isempty(subarr)
        continue
    else
        % Then get indices of Year and Mon matchups (from Date components)
        [~,yrint] = ismember(subarr.Year_date,jdi_psppb_lalosub.Year(x));
        [~,moint] = ismember(subarr.Mon_date,jdi_psppb_lalosub.Month(x));
        dtint = ismember(yrint,moint);
        gbf_ids = find(dtint == 1); % Retain ALL indices of matchup to single JeDI value
        dtidx = idxint(gbf_ids);
    end
    
    if isempty(dtint)
        continue
    else
        gbf_psppb_dtids = [gbf_psppb_dtids;dtidx];
    end 
end

% 2c: Use subset index values to get 'Arr_RowNum' index values from larger
% 'gbf_patl' array --> to remove the correct rows from the *overall* array
gbf_psppb_rmids = gbf_psppb_lalosub.Arr_RowNum(gbf_psppb_dtids);
gbf_pspp_cut = gbf_pspp_cuta;
gbf_pspp_cut(gbf_psppb_rmids,:) = []; % NEW subset array with duplicates (with other DB) removed


% %%%%%% 2. Pyrosoma atlanticum %%%%%% 
% Primary ('keep') array: JeDI
% Secondary ('discard') array: GBIF
% 0: Add column of 'row numbers' to "overall" 'patl_array' to keep track
% for eventual index removal
gbf_patl_ids = [gbf_pyra_patl table((1:1:height(gbf_pyra_patl))')];
gbf_patl_ids.Properties.VariableNames([end]) = {'Arr_RowNum'};

% 1a: First, find LAT & LON duplicates between GBIF and JeDI
latids_jdi_pa = [];
latids_gbf_pa = [];
for j=1:height(jdi_patl)
    for g=1:height(gbf_patl_ids)
        cmp = abs(jdi_patl.Lat(j)-gbf_patl_ids.Lat_dec(g));
        if cmp <= 0.1
            latids_jdi_pa = [latids_jdi_pa;j];
            latids_gbf_pa = [latids_gbf_pa;g];
        end
    end
end
lonids_jdi_pa = [];
lonids_gbf_pa = [];
for j=1:height(jdi_patl)
    for g=1:height(gbf_patl_ids)
        cmp = abs(jdi_patl.Lon(j)-gbf_patl_ids.Lon_dec(g));
        if cmp <= 0.1
            lonids_jdi_pa = [lonids_jdi_pa;j];
            lonids_gbf_pa = [lonids_gbf_pa;g];
        end
    end
end

% 1b: Assess which LAT & LON indices overlap --> to get subset of indices 
% that contain *both* Lat and Lon overlap (i.e., not just Lat OR Lon)
idsjdipa = intersect(latids_jdi_pa,lonids_jdi_pa);
idsgbfpa = intersect(latids_gbf_pa,lonids_gbf_pa);

% 2a: for subset of Lat/Lon matchups, find DATE (MM-YYY) overlaps
jdi_patl_lalosub = jdi_patl(idsjdipa,:);
gbf_patl_lalosub = gbf_patl_ids(idsgbfpa,:);

% 2b: Check additional match-up of Lats/Lons via *Dates*
gbf_patl_dtids = [];
for x = 1:height(jdi_patl_lalosub)
    % First, get the GBIF indices that match each *individual* JeDI Lat &
    % Lon (have to "re-go-through" the subset of all matched idxs (same as
    % Step 1 above, but just for ONE JeDI Lat & Lon)
    latidx = find(abs(gbf_patl_lalosub.Lat_dec-jdi_patl_lalosub.Lat(x)) <= 0.1);
    lonidx = find(abs(gbf_patl_lalosub.Lon_dec-jdi_patl_lalosub.Lon(x)) <= 0.1);
    idxint = intersect(latidx,lonidx);                
    subarr = gbf_patl_lalosub(idxint,:);
    
    if isempty(subarr)
        continue
    else
        % Then get indices of Year and Mon matchups (from Date components)
        [~,yrint] = ismember(subarr.Year_date,jdi_patl_lalosub.Year(x));
        [~,moint] = ismember(subarr.Mon_date,jdi_patl_lalosub.Month(x));
        dtint = ismember(yrint,moint);
        gbf_ids = find(dtint == 1); % Retain ALL indices of matchup to single JeDI value
        dtidx = idxint(gbf_ids);
    end
    
    if isempty(dtint)
        continue
    else
        gbf_patl_dtids = [gbf_patl_dtids;dtidx];
    end 
end

% 2c: Use subset index values to get 'Arr_RowNum' index values from larger
% 'gbf_patl' array --> to remove the correct rows from the *overall* array
gbf_patl_rmids = gbf_patl_lalosub.Arr_RowNum(gbf_patl_dtids);
gbf_patl_cut = gbf_pyra_patl;
gbf_patl_cut(gbf_patl_rmids,:) = []; % NEW subset array with duplicates (with other DB) removed



% %%%%%% 3. Pyrostremma spinosum %%%%%% 
% Primary ('keep') array: JeDI
% Secondary ('discard') array: GBIF
% 0: Add column of 'row numbers' to "overall" 'patl_array' to keep track
% for eventual index removal
gbf_tspi_ids = [gbf_pyrt_tspi table((1:1:height(gbf_pyrt_tspi))')];
gbf_tspi_ids.Properties.VariableNames([end]) = {'Arr_RowNum'};

% 1a: First, find LAT & LON duplicates between GBIF and JeDI
latids_jdi_tp = [];
latids_gbf_tp = [];
for j=1:height(jdi_tspi)
    for g=1:height(gbf_tspi_ids)
        cmp = abs(jdi_tspi.Lat(j)-gbf_tspi_ids.Lat_dec(g));
        if cmp <= 0.1
            latids_jdi_tp = [latids_jdi_tp;j];
            latids_gbf_tp = [latids_gbf_tp;g];
        end
    end
end
lonids_jdi_tp = [];
lonids_gbf_tp = [];
for j=1:height(jdi_tspi)
    for g=1:height(gbf_tspi_ids)
        cmp = abs(jdi_tspi.Lon(j)-gbf_tspi_ids.Lon_dec(g));
        if cmp <= 0.1
            lonids_jdi_tp = [lonids_jdi_tp;j];
            lonids_gbf_tp = [lonids_gbf_tp;g];
        end
    end
end

% 1b: Assess which LAT & LON indices overlap --> to get subset of indices 
% that contain *both* Lat and Lon overlap (i.e., not just Lat OR Lon)
idsjditp = intersect(latids_jdi_tp,lonids_jdi_tp);
idsgbftp = intersect(latids_gbf_tp,lonids_gbf_tp);

% 2a: for subset of Lat/Lon matchups, find DATE (MM-YYY) overlaps
jdi_tspi_lalosub = jdi_tspi(idsjditp,:);
gbf_tspi_lalosub = gbf_tspi_ids(idsgbftp,:);

% 2b: Check additional match-up of Lats/Lons via *Dates*
gbf_tspi_dtids = [];
for x = 1:height(jdi_tspi_lalosub)
    % First, get the GBIF indices that match each *individual* JeDI Lat &
    % Lon (have to "re-go-through" the subset of all matched idxs (same as
    % Step 1 above, but just for ONE JeDI Lat & Lon)
    latidx = find(abs(gbf_tspi_lalosub.Lat_dec-jdi_tspi_lalosub.Lat(x)) <= 0.1);
    lonidx = find(abs(gbf_tspi_lalosub.Lon_dec-jdi_tspi_lalosub.Lon(x)) <= 0.1);
    idxint = intersect(latidx,lonidx);                
    subarr = gbf_tspi_lalosub(idxint,:);
    
    if isempty(subarr)
        continue
    else
        % Then get indices of Year and Mon matchups (from Date components)
        [~,yrint] = ismember(subarr.Year_date,jdi_tspi_lalosub.Year(x));
        [~,moint] = ismember(subarr.Mon_date,jdi_tspi_lalosub.Month(x));
        dtint = ismember(yrint,moint);
        gbf_ids = find(dtint == 1); % Retain ALL indices of matchup to single JeDI value
        dtidx = idxint(gbf_ids);
    end
    
    if isempty(dtint)
        continue
    else
        gbf_tspi_dtids = [gbf_tspi_dtids;dtidx];
    end 
end

% 2c: Use subset index values to get 'Arr_RowNum' index values from larger
% 'gbf_patl' array --> to remove the correct rows from the *overall* array
gbf_tspi_rmids = gbf_tspi_lalosub.Arr_RowNum(gbf_tspi_dtids);
gbf_tspi_cut = gbf_pyrt_tspi;
gbf_tspi_cut(gbf_tspi_rmids,:) = []; % NEW subset array with duplicates (with other DB) removed



% %%%%%% 4. Pyrostremma agassizi %%%%%% 
% Primary ('keep') array: JeDI
% Secondary ('discard') array: GBIF
% 0: Add column of 'row numbers' to "overall" 'patl_array' to keep track
% for eventual index removal
gbf_taga_ids = [gbf_pyrt_taga table((1:1:height(gbf_pyrt_taga))')];
gbf_taga_ids.Properties.VariableNames([end]) = {'Arr_RowNum'};

% 1a: First, find LAT & LON duplicates between GBIF and JeDI
latids_jdi_ta = [];
latids_gbf_ta = [];
for j=1:height(jdi_taga)
    for g=1:height(gbf_taga_ids)
        cmp = abs(jdi_taga.Lat(j)-gbf_taga_ids.Lat_dec(g));
        if cmp <= 0.1
            latids_jdi_ta = [latids_jdi_ta;j];
            latids_gbf_ta = [latids_gbf_ta;g];
        end
    end
end
lonids_jdi_ta = [];
lonids_gbf_ta = [];
for j=1:height(jdi_taga)
    for g=1:height(gbf_taga_ids)
        cmp = abs(jdi_taga.Lon(j)-gbf_taga_ids.Lon_dec(g));
        if cmp <= 0.1
            lonids_jdi_ta = [lonids_jdi_ta;j];
            lonids_gbf_ta = [lonids_gbf_ta;g];
        end
    end
end

% 1b: Assess which LAT & LON indices overlap --> to get subset of indices 
% that contain *both* Lat and Lon overlap (i.e., not just Lat OR Lon)
idsjdita = intersect(latids_jdi_ta,lonids_jdi_ta);
idsgbfta = intersect(latids_gbf_ta,lonids_gbf_ta);

% 2a: for subset of Lat/Lon matchups, find DATE (MM-YYY) overlaps
jdi_taga_lalosub = jdi_taga(idsjdita,:);
gbf_taga_lalosub = gbf_taga_ids(idsgbfta,:);

% 2b: Check additional match-up of Lats/Lons via *Dates*
gbf_taga_dtids = [];
for x = 1:height(jdi_taga_lalosub)
    % First, get the GBIF indices that match each *individual* JeDI Lat &
    % Lon (have to "re-go-through" the subset of all matched idxs (same as
    % Step 1 above, but just for ONE JeDI Lat & Lon)
    latidx = find(abs(gbf_taga_lalosub.Lat_dec-jdi_taga_lalosub.Lat(x)) <= 0.1);
    lonidx = find(abs(gbf_taga_lalosub.Lon_dec-jdi_taga_lalosub.Lon(x)) <= 0.1);
    idxint = intersect(latidx,lonidx);                
    subarr = gbf_taga_lalosub(idxint,:);
    
    if isempty(subarr)
        continue
    else
        % Then get indices of Year and Mon matchups (from Date components)
        [~,yrint] = ismember(subarr.Year_date,jdi_taga_lalosub.Year(x));
        [~,moint] = ismember(subarr.Mon_date,jdi_taga_lalosub.Month(x));
        dtint = ismember(yrint,moint);
        gbf_ids = find(dtint == 1); % Retain ALL indices of matchup to single JeDI value
        dtidx = idxint(gbf_ids);
    end
    
    if isempty(dtint)
        continue
    else
        gbf_taga_dtids = [gbf_taga_dtids;dtidx];
    end 
end

% 2c: Use subset index values to get 'Arr_RowNum' index values from larger
% 'gbf_patl' array --> to remove the correct rows from the *overall* array
gbf_taga_rmids = gbf_taga_lalosub.Arr_RowNum(gbf_taga_dtids);
gbf_taga_cut = gbf_pyrt_taga;
gbf_taga_cut(gbf_taga_rmids,:) = []; % NEW subset array with duplicates (with other DB) removed



% %%%%%% 5. Pyrosomella verticillata %%%%%% 
% Primary ('keep') array: JeDI
% Secondary ('discard') array: GBIF
% 0: Add column of 'row numbers' to "overall" 'patl_array' to keep track
% for eventual index removal
gbf_lver_ids = [gbf_pyrl_lver table((1:1:height(gbf_pyrl_lver))')];
gbf_lver_ids.Properties.VariableNames([end]) = {'Arr_RowNum'};

% 1a: First, find LAT & LON duplicates between GBIF and JeDI
latids_jdi_lv = [];
latids_gbf_lv = [];
for j=1:height(jdi_lver)
    for g=1:height(gbf_lver_ids)
        cmp = abs(jdi_lver.Lat(j)-gbf_lver_ids.Lat_dec(g));
        if cmp <= 0.1
            latids_jdi_lv = [latids_jdi_lv;j];
            latids_gbf_lv = [latids_gbf_lv;g];
        end
    end
end
lonids_jdi_lv = [];
lonids_gbf_lv = [];
for j=1:height(jdi_lver)
    for g=1:height(gbf_lver_ids)
        cmp = abs(jdi_lver.Lon(j)-gbf_lver_ids.Lon_dec(g));
        if cmp <= 0.1
            lonids_jdi_lv = [lonids_jdi_lv;j];
            lonids_gbf_lv = [lonids_gbf_lv;g];
        end
    end
end

% 1b: Assess which LAT & LON indices overlap --> to get subset of indices 
% that contain *both* Lat and Lon overlap (i.e., not just Lat OR Lon)
idsjdilv = intersect(latids_jdi_lv,lonids_jdi_lv);
idsgbflv = intersect(latids_gbf_lv,lonids_gbf_lv);

% 2a: for subset of Lat/Lon matchups, find DATE (MM-YYY) overlaps
jdi_lver_lalosub = jdi_lver(idsjdilv,:);
gbf_lver_lalosub = gbf_lver_ids(idsgbflv,:);

% 2b: Check additional match-up of Lats/Lons via *Dates*
gbf_lver_dtids = [];
for x = 1:height(jdi_lver_lalosub)
    % First, get the GBIF indices that match each *individual* JeDI Lat &
    % Lon (have to "re-go-through" the subset of all matched idxs (same as
    % Step 1 above, but just for ONE JeDI Lat & Lon)
    latidx = find(abs(gbf_lver_lalosub.Lat_dec-jdi_lver_lalosub.Lat(x)) <= 0.1);
    lonidx = find(abs(gbf_lver_lalosub.Lon_dec-jdi_lver_lalosub.Lon(x)) <= 0.1);
    idxint = intersect(latidx,lonidx);                
    subarr = gbf_lver_lalosub(idxint,:);
    
    if isempty(subarr)
        continue
    else
        % Then get indices of Year and Mon matchups (from Date components)
        [~,yrint] = ismember(subarr.Year_date,jdi_lver_lalosub.Year(x));
        [~,moint] = ismember(subarr.Mon_date,jdi_lver_lalosub.Month(x));
        dtint = ismember(yrint,moint);
        gbf_ids = find(dtint == 1); % Retain ALL indices of matchup to single JeDI value
        dtidx = idxint(gbf_ids);
    end
    
    if isempty(dtint)
        continue
    else
        gbf_lver_dtids = [gbf_lver_dtids;dtidx];
    end 
end

% 2c: Use subset index values to get 'Arr_RowNum' index values from larger
% 'gbf_patl' array --> to remove the correct rows from the *overall* array
gbf_lver_rmids = gbf_lver_lalosub.Arr_RowNum(gbf_lver_dtids);
gbf_lver_cut = gbf_pyrl_lver;
gbf_lver_cut(gbf_lver_rmids,:) = []; % NEW subset array with duplicates (with other DB) removed




%% ======= Step 2: FOR EACH SPECIES-LEVEL (subset) DB, remove duplicate samples ========  
% WITHIN EACH *subsetted, non-overlapping* DB (COPE, JeDI, or GBIF),
% check that each record is unique by Lat, Lon, Year, Mon (but NOT
% with any 0.1-deg leeway, because that was only to account for different
% reporting formats by database)

% %%% 1.1. Pyrosoma spp. (COPEPOD, 'cpd_pyro_nnzro')
cpd_pspp_subtbl = cpd_pyro_nnzro(:,[2:4,7:8]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,cpd_pspp_ids] = unique(cpd_pspp_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
cpd_pspp_cln = cpd_pyro_nnzro(cpd_pspp_ids,:);
cpd_pspp_cln([isnan(cpd_pspp_cln.YEAR) |  isnan(cpd_pspp_cln.MON) |  isnan(cpd_pspp_cln.LATITUDE) | isnan(cpd_pspp_cln.LONGITDE)],:) = [];

% %%% 1.2. Pyrosoma spp. (JeDI - cut, 'jdi_pspp_cut')
jdi_pspp_subtbl = jdi_pspp_cut(:,[5:9]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,jdi_pspp_ids] = unique(jdi_pspp_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
jdi_pspp_cln = jdi_pspp_cut(jdi_pspp_ids,:);
jdi_pspp_cln([(jdi_pspp_cln.Year == 9999) | (jdi_pspp_cln.Month == 99) |  isnan(jdi_pspp_cln.Lat) | isnan(jdi_pspp_cln.Lon)],:) = [];

% %%% 1.3. Pyrosoma spp. (GBIF - cut, 'gbf_pspp_cut')
gbf_pspp_subtbl = gbf_pspp_cut(:,[5:9]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,gbf_pspp_ids] = unique(gbf_pspp_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
gbf_pspp_cln = gbf_pspp_cut(gbf_pspp_ids,:);
gbf_pspp_cln([(gbf_pspp_cln.Year_date == 9999) | (gbf_pspp_cln.Mon_date == 99) |  isnan(gbf_pspp_cln.Lat_dec) | isnan(gbf_pspp_cln.Lon_dec)],:) = [];


% %%% 2.1. P. atlanticum (JeDI)
jdi_patl_subtbl = jdi_patl(:,[5:9]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,jdi_patl_ids] = unique(jdi_patl_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
jdi_patl_cln = jdi_patl(jdi_patl_ids,:);
jdi_patl_cln([(jdi_patl_cln.Year == 9999) | (jdi_patl_cln.Month == 99) |  isnan(jdi_patl_cln.Lat) | isnan(jdi_patl_cln.Lon)],:) = [];

% %%% 2.2. P. atlanticum (GBIF)
gbf_patl_subtbl = gbf_patl_cut(:,[5:9]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,gbf_patl_unq] = unique(gbf_patl_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
gbf_patl_cln = gbf_patl_cut(gbf_patl_unq,:);
gbf_patl_cln([(gbf_patl_cln.Year_date == 9999) | (gbf_patl_cln.Mon_date == 99) |  isnan(gbf_patl_cln.Lat_dec) | isnan(gbf_patl_cln.Lon_dec)],:) = [];


% % %%% 3.1. P. aherniosum (GBIF) --> NO records
% gbf_pahe_subtbl = gbf_pyra_pahe(:,[5:9]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
% gbf_pahe_unq = unique(gbf_pahe_subtbl,'rows'); % Get unique rows for those
% % %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
% gbf_pahe_cln = gbf_pahe_unq;
% gbf_pahe_cln([(gbf_pahe_cln.Year_date == 9999) | (gbf_pahe_cln.Mon_date == 99) |  isnan(gbf_pahe_cln.Lat_dec) | isnan(gbf_pahe_cln.Lon_dec)],:) = [];


% % %%% 4.1. P. godeauxi (GBIF) --> NO records
% gbf_pgod_subtbl = gbf_pyra_pgod(:,[5:9]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
% gbf_pgod_unq = unique(gbf_pgod_subtbl,'rows'); % Get unique rows for those
% % %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
% gbf_pgod_cln = gbf_pgod_unq;
% gbf_pgod_cln([(gbf_pgod_cln.Year_date == 9999) | (gbf_pgod_cln.Mon_date == 99) |  isnan(gbf_pgod_cln.Lat_dec) | isnan(gbf_pgod_cln.Lon_dec)],:) = [];


% % %%% 5.1. P. ovatum (GBIF) --> NO records
% gbf_pova_subtbl = gbf_pyra_pova(:,[5:9]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
% gbf_pova_unq = unique(gbf_pova_subtbl,'rows'); % Get unique rows for those
% % %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
% gbf_pova_cln = gbf_pova_unq;
% gbf_pova_cln([(gbf_pova_cln.Year_date == 9999) | (gbf_pova_cln.Mon_date == 99) |  isnan(gbf_pova_cln.Lat_dec) | isnan(gbf_pova_cln.Lon_dec)],:) = [];


% %%% 6.1. Pyrostremma spp. (GBIF)
gbf_tspp_subtbl = gbf_pyrt_tspp(:,[5:9]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,gbf_tspp_ids] = unique(gbf_tspp_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
gbf_tspp_cln = gbf_pyrt_tspp(gbf_tspp_ids,:);
gbf_tspp_cln([(gbf_tspp_cln.Year_date == 9999) | (gbf_tspp_cln.Mon_date == 99) |  isnan(gbf_tspp_cln.Lat_dec) | isnan(gbf_tspp_cln.Lon_dec)],:) = [];


% %%% 7.1. Pt. spinosum (JeDI)
jdi_tspi_subtbl = jdi_tspi(:,[5:9]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,jdi_tspi_ids] = unique(jdi_tspi_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
jdi_tspi_cln = jdi_tspi(jdi_tspi_ids,:);
jdi_tspi_cln([(jdi_tspi_cln.Year == 9999) | (jdi_tspi_cln.Month == 99) |  isnan(jdi_tspi_cln.Lat) | isnan(jdi_tspi_cln.Lon)],:) = [];

% %%% 7.2. Pt. spinosum (GBIF)
gbf_tspi_subtbl = gbf_tspi_cut(:,[5:9]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,gbf_tspi_ids] = unique(gbf_tspi_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
gbf_tspi_cln = gbf_tspi_cut(gbf_tspi_ids,:);
gbf_tspi_cln([(gbf_tspi_cln.Year_date == 9999) | (gbf_tspi_cln.Mon_date == 99) |  isnan(gbf_tspi_cln.Lat_dec) | isnan(gbf_tspi_cln.Lon_dec)],:) = [];


% %%% 8.1. Pt. agassizi (JeDI)
jdi_taga_subtbl = jdi_taga(:,[5:9]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,jdi_taga_ids] = unique(jdi_taga_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
jdi_taga_cln = jdi_taga(jdi_taga_ids,:);
jdi_taga_cln([(jdi_taga_cln.Year == 9999) | (jdi_taga_cln.Month == 99) |  isnan(jdi_taga_cln.Lat) | isnan(jdi_taga_cln.Lon)],:) = [];

% %%% 8.2. Pt. agassizi (GBIF)
gbf_taga_subtbl = gbf_taga_cut(:,[5:9]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,gbf_taga_ids] = unique(gbf_taga_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
gbf_taga_cln = gbf_taga_cut(gbf_taga_ids,:);
gbf_taga_cln([(gbf_taga_cln.Year_date == 9999) | (gbf_taga_cln.Mon_date == 99) |  isnan(gbf_taga_cln.Lat_dec) | isnan(gbf_taga_cln.Lon_dec)],:) = [];


% %%% 9.1. Pyrosomella spp. (GBIF)
gbf_lspp_subtbl = gbf_pyrl_lspp(:,[5:9]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,gbf_lspp_ids] = unique(gbf_lspp_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
gbf_lspp_cln = gbf_pyrl_lspp(gbf_lspp_ids,:);
gbf_lspp_cln([(gbf_lspp_cln.Year_date == 9999) | (gbf_lspp_cln.Mon_date == 99) |  isnan(gbf_lspp_cln.Lat_dec) | isnan(gbf_lspp_cln.Lon_dec)],:) = [];


% %%% 10.1. Pl. verticillata (JeDI)
jdi_lver_subtbl = jdi_lver(:,[5:9]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,jdi_lver_ids] = unique(jdi_lver_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
jdi_lver_cln = jdi_lver(jdi_lver_ids,:);
jdi_lver_cln([(jdi_lver_cln.Year == 9999) | (jdi_lver_cln.Month == 99) |  isnan(jdi_lver_cln.Lat) | isnan(jdi_lver_cln.Lon)],:) = [];

% %%% 10.2. Pl. verticillata (GBIF)
gbf_lver_subtbl = gbf_lver_cut(:,[5:9]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,gbf_lver_ids] = unique(gbf_lver_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
gbf_lver_cln = gbf_lver_cut(gbf_lver_ids,:);
gbf_lver_cln([(gbf_lver_cln.Year_date == 9999) | (gbf_lver_cln.Mon_date == 99) |  isnan(gbf_lver_cln.Lat_dec) | isnan(gbf_lver_cln.Lon_dec)],:) = [];

