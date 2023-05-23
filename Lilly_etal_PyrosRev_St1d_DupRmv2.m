%%%%%%%%%%%%%%
%%% Codes for: 
%%%     Lilly et al. (in review). A Global Review of Pyrosomes:  
%%%     Shedding light on the ocean’s elusive gelatinous ‘fire-bodies’

% %% Part 4: Remove duplicate records: 
%       ii) within each individual database (following Step 3)


%% ======= Step ii: FOR EACH SPECIES-LEVEL (subset) DB, remove duplicate samples ========  
% WITHIN EACH *subsetted, non-overlapping* DB from Step 3 -> use '_fin' arrays (Lit, COPE, JeDI,GBIF, OBIS):
%   - check that each record is unique by Lat, Lon, Year, Mon (but NOT
%       with any 0.1-deg leeway, because that was only to account for different
%       reporting formats by database)


%% ======= Pyrosoma spp. =======
% %%% 1.1. Literature
lit_pspp_subtbl = lit_pspp_fin(:,[1,5:8]); % Subset for only: Year, Mon, Lat, Lon, Sci_name
[~,lit_pspp_ids] = unique(lit_pspp_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
lit_pspp_cln = lit_pspp_fin(lit_pspp_ids,:);
lit_pspp_cln([isnan(lit_pspp_cln.Year) |  isnan(lit_pspp_cln.Month) |  isnan(lit_pspp_cln.Lat_dec) | isnan(lit_pspp_cln.Lon_dec)],:) = [];

% %%% 1.2. COPEPOD
cpd_pspp_subtbl = cpd_pspp_fin(:,[2:3,7:8]); % Subset for only: Year, Mon, Lat, Lon, Sci_name
[~,cpd_pspp_ids] = unique(cpd_pspp_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
cpd_pspp_cln = cpd_pspp_fin(cpd_pspp_ids,:);
cpd_pspp_cln([isnan(cpd_pspp_cln.Year) |  isnan(cpd_pspp_cln.Month) |  isnan(cpd_pspp_cln.Lat_dec) | isnan(cpd_pspp_cln.Lon_dec)],:) = [];

% %%% 1.3. JeDI
jdi_pspp_subtbl = jdi_pspp_fin(:,[5:6,8:9,13]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,jdi_pspp_ids] = unique(jdi_pspp_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
jdi_pspp_cln = jdi_pspp_fin(jdi_pspp_ids,:);
jdi_pspp_cln([(jdi_pspp_cln.Year == 9999) | (jdi_pspp_cln.Month == 99) |  isnan(jdi_pspp_cln.Lat_dec) | isnan(jdi_pspp_cln.Lon_dec)],:) = [];

% %%% 1.4. GBIF
gbf_pspp_subtbl = gbf_pspp_fin(:,[5:6,8:10]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,gbf_pspp_ids] = unique(gbf_pspp_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
gbf_pspp_cln = gbf_pspp_fin(gbf_pspp_ids,:);
gbf_pspp_cln([(gbf_pspp_cln.Year == 9999) | (gbf_pspp_cln.Month == 99) |  isnan(gbf_pspp_cln.Lat_dec) | isnan(gbf_pspp_cln.Lon_dec)],:) = [];

% %%% 1.5. OBIS
obi_pspp_subtbl = obi_pspp_fin(:,[1:2,4,11:12]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,obi_pspp_ids] = unique(obi_pspp_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
obi_pspp_cln = obi_pspp_fin(obi_pspp_ids,:);
obi_pspp_cln([(obi_pspp_cln.Year == 9999) | (obi_pspp_cln.Month == 99) |  isnan(obi_pspp_cln.Lat_dec) | isnan(obi_pspp_cln.Lon_dec)],:) = [];


%% ======= P. atlanticum =======
% %%% 2.1. Literature
lit_patl_subtbl = lit_patl_fin(:,[1,5:8]); % Subset for only: Year, Mon, Lat, Lon, Sci_name
[~,lit_patl_ids] = unique(lit_patl_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
lit_patl_cln = lit_patl_fin(lit_patl_ids,:);
lit_patl_cln([isnan(lit_patl_cln.Year) |  isnan(lit_patl_cln.Month) |  isnan(lit_patl_cln.Lat_dec) | isnan(lit_patl_cln.Lon_dec)],:) = [];

% %%% 2.2. JeDI
jdi_patl_subtbl = jdi_patl_fin(:,[5:6,8:9,13]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,jdi_patl_ids] = unique(jdi_patl_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
jdi_patl_cln = jdi_patl_fin(jdi_patl_ids,:);
jdi_patl_cln([(jdi_patl_cln.Year == 9999) | (jdi_patl_cln.Month == 99) |  isnan(jdi_patl_cln.Lat_dec) | isnan(jdi_patl_cln.Lon_dec)],:) = [];

% %%% 2.3. GBIF
gbf_patl_subtbl = gbf_patl_fin(:,[5:6,8:10]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,gbf_patl_ids] = unique(gbf_patl_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
gbf_patl_cln = gbf_patl_fin(gbf_patl_ids,:);
gbf_patl_cln([(gbf_patl_cln.Year == 9999) | (gbf_patl_cln.Month == 99) |  isnan(gbf_patl_cln.Lat_dec) | isnan(gbf_patl_cln.Lon_dec)],:) = [];

% %%% 2.4. OBIS
obi_patl_subtbl = obi_patl_fin(:,[1:2,4,11:12]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,obi_patl_ids] = unique(obi_patl_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
obi_patl_cln = obi_patl_fin(obi_patl_ids,:);
obi_patl_cln([(obi_patl_cln.Year == 9999) | (obi_patl_cln.Month == 99) |  isnan(obi_patl_cln.Lat_dec) | isnan(obi_patl_cln.Lon_dec)],:) = [];


%% ======= P. aherniosum =======
% %%% 3.1. Literature
lit_pahe_subtbl = lit_pahe_fin(:,[1,5:8]); % Subset for only: Year, Mon, Lat, Lon, Sci_name
[~,lit_pahe_ids] = unique(lit_pahe_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
lit_pahe_cln = lit_pahe_fin(lit_pahe_ids,:);
lit_pahe_cln([isnan(lit_pahe_cln.Year) |  isnan(lit_pahe_cln.Month) |  isnan(lit_pahe_cln.Lat_dec) | isnan(lit_pahe_cln.Lon_dec)],:) = [];

% % %%% 3.2. GBIF --> NO records
% gbf_pahe_subtbl = gbf_pyra_pahe(:,[5:9]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
% gbf_pahe_unq = unique(gbf_pahe_subtbl,'rows'); % Get unique rows for those
% % %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
% gbf_pahe_cln = gbf_pahe_unq;
% gbf_pahe_cln([(gbf_pahe_cln.Year_date == 9999) | (gbf_pahe_cln.Mon_date == 99) |  isnan(gbf_pahe_cln.Lat_dec) | isnan(gbf_pahe_cln.Lon_dec)],:) = [];

% %%% 3.3. OBIS
obi_pahe_subtbl = obi_pahe_fin(:,[1:2,4,11:12]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,obi_pahe_ids] = unique(obi_pahe_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
obi_pahe_cln = obi_pahe_fin(obi_pahe_ids,:);
obi_pahe_cln([(obi_pahe_cln.Year == 9999) | (obi_pahe_cln.Month == 99) |  isnan(obi_pahe_cln.Lat_dec) | isnan(obi_pahe_cln.Lon_dec)],:) = [];


%% ======= P. godeauxi =======
% % %%% 4.1. P. godeauxi (GBIF) --> NO records
% gbf_pgod_subtbl = gbf_pyra_pgod(:,[5:9]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
% gbf_pgod_unq = unique(gbf_pgod_subtbl,'rows'); % Get unique rows for those
% % %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
% gbf_pgod_cln = gbf_pgod_unq;
% gbf_pgod_cln([(gbf_pgod_cln.Year_date == 9999) | (gbf_pgod_cln.Mon_date == 99) |  isnan(gbf_pgod_cln.Lat_dec) | isnan(gbf_pgod_cln.Lon_dec)],:) = [];


%% ======= P. ovatum =======
% % %%% 5.1. P. ovatum (GBIF) --> NO records
% gbf_pova_subtbl = gbf_pyra_pova(:,[5:9]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
% gbf_pova_unq = unique(gbf_pova_subtbl,'rows'); % Get unique rows for those
% % %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
% gbf_pova_cln = gbf_pova_unq;
% gbf_pova_cln([(gbf_pova_cln.Year_date == 9999) | (gbf_pova_cln.Mon_date == 99) |  isnan(gbf_pova_cln.Lat_dec) | isnan(gbf_pova_cln.Lon_dec)],:) = [];

% %%% 5.2. OBIS
obi_pova_subtbl = obi_pova_fin(:,[1:2,4,11:12]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,obi_pova_ids] = unique(obi_pova_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
obi_pova_cln = obi_pova_fin(obi_pova_ids,:);
obi_pova_cln([(obi_pova_cln.Year == 9999) | (obi_pova_cln.Month == 99) |  isnan(obi_pova_cln.Lat_dec) | isnan(obi_pova_cln.Lon_dec)],:) = [];


%% ======= Pyrostremma spp. =======
% %%% 6.1. GBIF
gbf_tspp_subtbl = gbf_tspp_fin(:,[5:6,8:10]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,gbf_tspp_ids] = unique(gbf_tspp_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
gbf_tspp_cln = gbf_tspp_fin(gbf_tspp_ids,:);
gbf_tspp_cln([(gbf_tspp_cln.Year == 9999) | (gbf_tspp_cln.Month == 99) |  isnan(gbf_tspp_cln.Lat_dec) | isnan(gbf_tspp_cln.Lon_dec)],:) = [];


%% ======= Pr. spinosum =======
% %%% 7.1. Literature
lit_tspi_subtbl = lit_tspi_fin(:,[1,5:8]); % Subset for only: Year, Mon, Lat, Lon, Sci_name
[~,lit_tspi_ids] = unique(lit_tspi_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
lit_tspi_cln = lit_tspi_fin(lit_tspi_ids,:);
lit_tspi_cln([isnan(lit_tspi_cln.Year) |  isnan(lit_tspi_cln.Month) |  isnan(lit_tspi_cln.Lat_dec) | isnan(lit_tspi_cln.Lon_dec)],:) = [];

% %%% 7.2. JeDI
jdi_tspi_subtbl = jdi_tspi_fin(:,[5:6,8:9,13]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,jdi_tspi_ids] = unique(jdi_tspi_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
jdi_tspi_cln = jdi_tspi_fin(jdi_tspi_ids,:);
jdi_tspi_cln([(jdi_tspi_cln.Year == 9999) | (jdi_tspi_cln.Month == 99) |  isnan(jdi_tspi_cln.Lat_dec) | isnan(jdi_tspi_cln.Lon_dec)],:) = [];

% %%% 7.3. GBIF
gbf_tspi_subtbl = gbf_tspi_fin(:,[5:6,8:10]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,gbf_tspi_ids] = unique(gbf_tspi_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
gbf_tspi_cln = gbf_tspi_fin(gbf_tspi_ids,:);
gbf_tspi_cln([(gbf_tspi_cln.Year == 9999) | (gbf_tspi_cln.Month == 99) |  isnan(gbf_tspi_cln.Lat_dec) | isnan(gbf_tspi_cln.Lon_dec)],:) = [];

% %%% 7.4. OBIS
obi_tspi_subtbl = obi_tspi_fin(:,[1:2,4,11:12]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,obi_tspi_ids] = unique(obi_tspi_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
obi_tspi_cln = obi_tspi_fin(obi_tspi_ids,:);
obi_tspi_cln([(obi_tspi_cln.Year == 9999) | (obi_tspi_cln.Month == 99) |  isnan(obi_tspi_cln.Lat_dec) | isnan(obi_tspi_cln.Lon_dec)],:) = [];


%% ======= Pr. agassizi =======
% %%% 8.1. JeDI
jdi_taga_subtbl = jdi_taga_fin(:,[5:6,8:9,13]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,jdi_taga_ids] = unique(jdi_taga_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
jdi_taga_cln = jdi_taga_fin(jdi_taga_ids,:);
jdi_taga_cln([(jdi_taga_cln.Year == 9999) | (jdi_taga_cln.Month == 99) |  isnan(jdi_taga_cln.Lat_dec) | isnan(jdi_taga_cln.Lon_dec)],:) = [];

% %%% 8.2. GBIF
gbf_taga_subtbl = gbf_taga_fin(:,[5:6,8:10]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,gbf_taga_ids] = unique(gbf_taga_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
gbf_taga_cln = gbf_taga_fin(gbf_taga_ids,:);
gbf_taga_cln([(gbf_taga_cln.Year == 9999) | (gbf_taga_cln.Month == 99) |  isnan(gbf_taga_cln.Lat_dec) | isnan(gbf_taga_cln.Lon_dec)],:) = [];

% %%% 8.3. OBIS
obi_taga_subtbl = obi_taga_fin(:,[1:2,4,11:12]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,obi_taga_ids] = unique(obi_taga_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
obi_taga_cln = obi_taga_fin(obi_taga_ids,:);
obi_taga_cln([(obi_taga_cln.Year == 9999) | (obi_taga_cln.Month == 99) |  isnan(obi_taga_cln.Lat_dec) | isnan(obi_taga_cln.Lon_dec)],:) = [];


%% ======= Pyrosomella spp. =======
% %%% 9.1. GBIF
gbf_lspp_subtbl = gbf_lspp_fin(:,[5:6,8:10]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,gbf_lspp_ids] = unique(gbf_lspp_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
gbf_lspp_cln = gbf_lspp_fin(gbf_lspp_ids,:);
gbf_lspp_cln([(gbf_lspp_cln.Year == 9999) | (gbf_lspp_cln.Month == 99) |  isnan(gbf_lspp_cln.Lat_dec) | isnan(gbf_lspp_cln.Lon_dec)],:) = [];

% %%% 9.2. OBIS
obi_lspp_subtbl = obi_lspp_fin(:,[1:2,4,11:12]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,obi_lspp_ids] = unique(obi_lspp_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
obi_lspp_cln = obi_lspp_fin(obi_lspp_ids,:);
obi_lspp_cln([(obi_lspp_cln.Year == 9999) | (obi_lspp_cln.Month == 99) |  isnan(obi_lspp_cln.Lat_dec) | isnan(obi_lspp_cln.Lon_dec)],:) = [];


%% ======= Pl. verticillata =======
% %%% 10.1. Literature
lit_lver_subtbl = lit_lver_fin(:,[1,5:8]); % Subset for only: Year, Mon, Lat, Lon, Sci_name
[~,lit_lver_ids] = unique(lit_lver_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
lit_lver_cln = lit_lver_fin(lit_lver_ids,:);
lit_lver_cln([isnan(lit_lver_cln.Year) |  isnan(lit_lver_cln.Month) |  isnan(lit_lver_cln.Lat_dec) | isnan(lit_lver_cln.Lon_dec)],:) = [];

% %%% 10.2. JeDI
jdi_lver_subtbl = jdi_lver_fin(:,[5:6,8:9,13]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,jdi_lver_ids] = unique(jdi_lver_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
jdi_lver_cln = jdi_lver_fin(jdi_lver_ids,:);
jdi_lver_cln([(jdi_lver_cln.Year == 9999) | (jdi_lver_cln.Month == 99) |  isnan(jdi_lver_cln.Lat_dec) | isnan(jdi_lver_cln.Lon_dec)],:) = [];

% %%% 10.3. GBIF
gbf_lver_subtbl = gbf_lver_fin(:,[5:6,8:10]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,gbf_lver_ids] = unique(gbf_lver_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
gbf_lver_cln = gbf_lver_fin(gbf_lver_ids,:);
gbf_lver_cln([(gbf_lver_cln.Year == 9999) | (gbf_lver_cln.Month == 99) |  isnan(gbf_lver_cln.Lat_dec) | isnan(gbf_lver_cln.Lon_dec)],:) = [];

% %%% 10.4. OBIS
obi_lver_subtbl = obi_lver_fin(:,[1:2,4,11:12]); % Subset for only: Year, Mon, Day, Lat, Lon, Sci_name
[~,obi_lver_ids] = unique(obi_lver_subtbl,'rows'); % Get unique rows for those
% %% CLEAN UP! - Year < 9999, Mon < 99, Lat =! NaN, Lon =! NaN
obi_lver_cln = obi_lver_fin(obi_lver_ids,:);
obi_lver_cln([(obi_lver_cln.Year == 9999) | (obi_lver_cln.Month == 99) |  isnan(obi_lver_cln.Lat_dec) | isnan(obi_lver_cln.Lon_dec)],:) = [];

