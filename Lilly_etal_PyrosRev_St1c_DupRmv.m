%%%%%%%%%%%%%%
%%% Codes for: 
%%%     Lilly et al. (in review). A Global Review of Pyrosomes:  
%%%     Shedding light on the ocean’s elusive gelatinous ‘fire-bodies’

% %% Part 3: Remove duplicate records: 
%       i) from overlapping databases


%% ======= Step i: Remove duplicate samples from multiple datasets ========  
% For each species group that had records in 2+ databases, we compared
% those databases for records with the same: Lat (<0.1 deg), Lon (<0.1
% deg), Date (Year & Mon)
% For duplicate records, we kept records from databases ordered as: 
% 1) Literature > 2) COPEPOD > 3) JeDI > 4) GBIF > 5) OBIS

% NOTE: for OBIS DB only, use only 'Lat, Lon, Year' for comparisons ->
% 'Month' is often missing/reported unreliably


%% ======= Step 1: Pyrosoma spp. =======
% Lit > COPEPOD > JeDI > GBIF > OBIS

% %%%% 1a: Lit vs. all DBs
% %% Lit vs. COPEPOD
% First, get all indices in secondary array (COPEPOD) that overlap with 
% primary array (Literature)
cpd_pspp_rm1 = [];
for l=1:height(lit_pyra_pspp)
    rm1id = find(abs(lit_pyra_pspp.Lat_dec(l)-cpd_pyra_pspp.Lat_dec)<0.1 & ...
                 abs(lit_pyra_pspp.Lon_dec(l)-cpd_pyra_pspp.Lon_dec)<0.1 & ...
                 (lit_pyra_pspp.Year(l) == cpd_pyra_pspp.Year) & ...
                 (lit_pyra_pspp.Month(l) == cpd_pyra_pspp.Month));
    if isempty(rm1id)
        continue
    else
        cpd_pspp_rm1 = [cpd_pspp_rm1;rm1id];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
cpd_pspp_sub1 = cpd_pyra_pspp;
cpd_pspp_sub1(cpd_pspp_rm1,:) = [];


% %% Lit vs. JeDI
% First, get all indices in secondary array that overlap with primary array 
jdi_pspp_rm1 = [];
for l=1:height(lit_pyra_pspp)
    rm1id = find(abs(lit_pyra_pspp.Lat_dec(l)-jdi_pyra_pspp.Lat_dec)<0.1 & ...
                 abs(lit_pyra_pspp.Lon_dec(l)-jdi_pyra_pspp.Lon_dec)<0.1 & ...
                 (lit_pyra_pspp.Year(l) == jdi_pyra_pspp.Year) & ...
                 (lit_pyra_pspp.Month(l) == jdi_pyra_pspp.Month));
    if isempty(rm1id)
        continue
    else
        jdi_pspp_rm1 = [jdi_pspp_rm1;rm1id];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
jdi_pspp_sub1 = jdi_pyra_pspp;
jdi_pspp_sub1(jdi_pspp_rm1,:) = [];


% %% Lit vs. GBIF
% First, get all indices in secondary array that overlap with primary array 
gbf_pspp_rm1 = [];
for l=1:height(lit_pyra_pspp)
    rm1id = find(abs(lit_pyra_pspp.Lat_dec(l)-gbf_pyra_pspp.Lat_dec)<0.1 & ...
                 abs(lit_pyra_pspp.Lon_dec(l)-gbf_pyra_pspp.Lon_dec)<0.1 & ...
                 (lit_pyra_pspp.Year(l) == gbf_pyra_pspp.Year) & ...
                 (lit_pyra_pspp.Month(l) == gbf_pyra_pspp.Month));
    if isempty(rm1id)
        continue
    else
        gbf_pspp_rm1 = [gbf_pspp_rm1;rm1id];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
gbf_pspp_sub1 = gbf_pyra_pspp;
gbf_pspp_sub1(gbf_pspp_rm1,:) = [];


% %% Lit vs. OBIS
% First, get all indices in secondary array that overlap with primary array
% NOTE: For OBIS DB ONLY - use only Lat, Lon, Year to compare (Month is
% reported unreliably)
obi_pspp_rm1 = [];
for l=1:height(lit_pyra_pspp)
    rm1id = find(abs(lit_pyra_pspp.Lat_dec(l)-obi_pyra_pspp.Lat_dec)<0.1 & ...
                 abs(lit_pyra_pspp.Lon_dec(l)-obi_pyra_pspp.Lon_dec)<0.1 & ...
                 (lit_pyra_pspp.Year(l) == obi_pyra_pspp.Year));
                 % (lit_pyra_pspp.Month(l) == obi_pyra_pspp.Month));
                    
    if isempty(rm1id)
        continue
    else
        obi_pspp_rm1 = [obi_pspp_rm1;rm1id];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
obi_pspp_sub1 = obi_pyra_pspp;
obi_pspp_sub1(obi_pspp_rm1,:) = [];


% %%%% 1b: COPEPOD (sub1) vs. remaining DBs (sub1) 
% %% COPEPOD vs. JeDI
% First, get all indices in secondary array that overlap with primary array
jdi_pspp_rm2 = [];
for l=1:height(cpd_pspp_sub1)
    rmid = find(abs(cpd_pspp_sub1.Lat_dec(l)-jdi_pspp_sub1.Lat_dec)<0.1 & ...
                 abs(cpd_pspp_sub1.Lon_dec(l)-jdi_pspp_sub1.Lon_dec)<0.1 & ...
                 (cpd_pspp_sub1.Year(l) == jdi_pspp_sub1.Year) & ...
                 (cpd_pspp_sub1.Month(l) == jdi_pspp_sub1.Month));
    if isempty(rmid)
        continue
    else
        jdi_pspp_rm2 = [jdi_pspp_rm2;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
jdi_pspp_sub2 = jdi_pspp_sub1;
jdi_pspp_sub2(jdi_pspp_rm2,:) = [];


% %% COPEPOD vs. GBIF
% First, get all indices in secondary array that overlap with primary array
gbf_pspp_rm2 = [];
for l=1:height(cpd_pspp_sub1)
    rmid = find(abs(cpd_pspp_sub1.Lat_dec(l)-gbf_pspp_sub1.Lat_dec)<0.1 & ...
                 abs(cpd_pspp_sub1.Lon_dec(l)-gbf_pspp_sub1.Lon_dec)<0.1 & ...
                 (cpd_pspp_sub1.Year(l) == gbf_pspp_sub1.Year) & ...
                 (cpd_pspp_sub1.Month(l) == gbf_pspp_sub1.Month));
    if isempty(rmid)
        continue
    else
        gbf_pspp_rm2 = [gbf_pspp_rm2;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
gbf_pspp_sub2 = gbf_pspp_sub1;
gbf_pspp_sub2(gbf_pspp_rm2,:) = [];


% %% COPEPOD vs. OBIS
% First, get all indices in secondary array that overlap with primary array
obi_pspp_rm2 = [];
for l=1:height(cpd_pspp_sub1)
    rmid = find(abs(cpd_pspp_sub1.Lat_dec(l)-obi_pspp_sub1.Lat_dec)<0.1 & ...
                 abs(cpd_pspp_sub1.Lon_dec(l)-obi_pspp_sub1.Lon_dec)<0.1 & ...
                 (cpd_pspp_sub1.Year(l) == obi_pspp_sub1.Year));
                 % (cpd_pspp_sub1.Month(l) == obi_pspp_sub1.Month));

    if isempty(rmid)
        continue
    else
        obi_pspp_rm2 = [obi_pspp_rm2;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
obi_pspp_sub2 = obi_pspp_sub1;
obi_pspp_sub2(obi_pspp_rm2,:) = [];


% %%%% 1c: JeDI (sub2) vs. remaining DBs (sub2) 
% %% JeDI vs. GBIF
% First, get all indices in secondary array that overlap with primary array
gbf_pspp_rm3 = [];
for l=1:height(jdi_pspp_sub2)
    rmid = find(abs(jdi_pspp_sub2.Lat_dec(l)-gbf_pspp_sub2.Lat_dec)<0.1 & ...
                 abs(jdi_pspp_sub2.Lon_dec(l)-gbf_pspp_sub2.Lon_dec)<0.1 & ...
                 (jdi_pspp_sub2.Year(l) == gbf_pspp_sub2.Year) & ...
                 (jdi_pspp_sub2.Month(l) == gbf_pspp_sub2.Month));
    if isempty(rmid)
        continue
    else
        gbf_pspp_rm3 = [gbf_pspp_rm3;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
gbf_pspp_sub3 = gbf_pspp_sub2;
gbf_pspp_sub3(gbf_pspp_rm3,:) = [];


% %% JeDI vs. OBIS
% First, get all indices in secondary array that overlap with primary array
obi_pspp_rm3 = [];
for l=1:height(jdi_pspp_sub2)
    rmid = find(abs(jdi_pspp_sub2.Lat_dec(l)-obi_pspp_sub2.Lat_dec)<0.1 & ...
                abs(jdi_pspp_sub2.Lon_dec(l)-obi_pspp_sub2.Lon_dec)<0.1 & ...
                (jdi_pspp_sub2.Year(l) == obi_pspp_sub2.Year));
                % (jdi_pspp_sub2.Month(l) == obi_pspp_sub2.Month));

    if isempty(rmid)
        continue
    else
        obi_pspp_rm3 = [obi_pspp_rm3;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
obi_pspp_sub3 = obi_pspp_sub2;
obi_pspp_sub3(obi_pspp_rm3,:) = [];


% %%%% 1d: GBIF (sub3) vs. OBIS (sub3) 
% First, get all indices in secondary array that overlap with primary array
obi_pspp_rm4 = [];
for l=1:height(gbf_pspp_sub3)
    rmid = find(abs(gbf_pspp_sub3.Lat_dec(l)-obi_pspp_sub3.Lat_dec)<0.1 & ...
                 abs(gbf_pspp_sub3.Lon_dec(l)-obi_pspp_sub3.Lon_dec)<0.1 & ...
                 (gbf_pspp_sub3.Year(l) == obi_pspp_sub3.Year));
                 % (gbf_pspp_sub3.Month(l) == obi_pspp_sub3.Month));

    if isempty(rmid)
        continue
    else
        obi_pspp_rm4 = [obi_pspp_rm4;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
obi_pspp_sub4 = obi_pspp_sub3;
obi_pspp_sub4(obi_pspp_rm4,:) = [];


% %% Rename all finalized subsets as '_fin'
lit_pspp_fin = lit_pyra_pspp;
cpd_pspp_fin = cpd_pspp_sub1;
jdi_pspp_fin = jdi_pspp_sub2;
gbf_pspp_fin = gbf_pspp_sub3;
obi_pspp_fin = obi_pspp_sub4;


%% ======= Step 2: P. atlanticum =======
% Lit > JeDI > GBIF > OBIS
% %%%% 2a: Lit vs. all DBs
% %% Lit vs. JeDI
jdi_patl_rm1 = [];
for l=1:height(lit_pyra_patl)
    rmid = find(abs(lit_pyra_patl.Lat_dec(l)-jdi_pyra_patl.Lat_dec)<0.1 & ...
                 abs(lit_pyra_patl.Lon_dec(l)-jdi_pyra_patl.Lon_dec)<0.1 & ...
                 (lit_pyra_patl.Year(l) == jdi_pyra_patl.Year) & ...
                 (lit_pyra_patl.Month(l) == jdi_pyra_patl.Month));
    if isempty(rmid)
        continue
    else
        jdi_patl_rm1 = [jdi_patl_rm1;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
jdi_patl_sub1 = jdi_pyra_patl;
jdi_patl_sub1(jdi_patl_rm1,:) = [];


% %% Lit vs. GBIF
gbf_patl_rm1 = [];
for l=1:height(lit_pyra_patl)
    rmid = find(abs(lit_pyra_patl.Lat_dec(l)-gbf_pyra_patl.Lat_dec)<0.1 & ...
                 abs(lit_pyra_patl.Lon_dec(l)-gbf_pyra_patl.Lon_dec)<0.1 & ...
                 (lit_pyra_patl.Year(l) == gbf_pyra_patl.Year) & ...
                 (lit_pyra_patl.Month(l) == gbf_pyra_patl.Month));
    if isempty(rmid)
        continue
    else
        gbf_patl_rm1 = [gbf_patl_rm1;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
gbf_patl_sub1 = gbf_pyra_patl;
gbf_patl_sub1(gbf_patl_rm1,:) = [];


% %% Lit vs. OBIS
obi_patl_rm1 = [];
for l=1:height(lit_pyra_patl)
    rmid = find(abs(lit_pyra_patl.Lat_dec(l)-obi_pyra_patl.Lat_dec)<0.1 & ...
                 abs(lit_pyra_patl.Lon_dec(l)-obi_pyra_patl.Lon_dec)<0.1 & ...
                 (lit_pyra_patl.Year(l) == obi_pyra_patl.Year));
                 % (lit_pyra_patl.Month(l) == obi_pyra_patl.Month));

    if isempty(rmid)
        continue
    else
        obi_patl_rm1 = [obi_patl_rm1;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
obi_patl_sub1 = obi_pyra_patl;
obi_patl_sub1(obi_patl_rm1,:) = [];


% %%%% 2b: JeDI (sub1) vs. remaining DBs (sub1) 
% %% JeDI vs. GBIF
% First, get all indices in secondary array that overlap with primary array
gbf_patl_rm2 = [];
for l=1:height(jdi_patl_sub1)
    rmid = find(abs(jdi_patl_sub1.Lat_dec(l)-gbf_patl_sub1.Lat_dec)<0.1 & ...
                 abs(jdi_patl_sub1.Lon_dec(l)-gbf_patl_sub1.Lon_dec)<0.1 & ...
                 (jdi_patl_sub1.Year(l) == gbf_patl_sub1.Year) & ...
                 (jdi_patl_sub1.Month(l) == gbf_patl_sub1.Month));
    if isempty(rmid)
        continue
    else
        gbf_patl_rm2 = [gbf_patl_rm2;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
gbf_patl_sub2 = gbf_patl_sub1;
gbf_patl_sub2(gbf_patl_rm2,:) = [];


% %% JeDI vs. OBIS
% First, get all indices in secondary array that overlap with primary array
obi_patl_rm2 = [];
for l=1:height(jdi_patl_sub1)
    rmid = find(abs(jdi_patl_sub1.Lat_dec(l)-obi_patl_sub1.Lat_dec)<0.1 & ...
                 abs(jdi_patl_sub1.Lon_dec(l)-obi_patl_sub1.Lon_dec)<0.1 & ...
                 (jdi_patl_sub1.Year(l) == obi_patl_sub1.Year));
                 % (jdi_patl_sub1.Month(l) == obi_patl_sub1.Month));

    if isempty(rmid)
        continue
    else
        obi_patl_rm2 = [obi_patl_rm2;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
obi_patl_sub2 = obi_patl_sub1;
obi_patl_sub2(obi_patl_rm2,:) = [];


% %%%% 2c: GBIF (sub2) vs. OBIS (sub2) 
% First, get all indices in secondary array that overlap with primary array
obi_patl_rm3 = [];
for l=1:height(gbf_patl_sub2)
    rmid = find(abs(gbf_patl_sub2.Lat_dec(l)-obi_patl_sub2.Lat_dec)<0.1 & ...
                 abs(gbf_patl_sub2.Lon_dec(l)-obi_patl_sub2.Lon_dec)<0.1 & ...
                 (gbf_patl_sub2.Year(l) == obi_patl_sub2.Year));
                 % (gbf_patl_sub2.Month(l) == obi_patl_sub2.Month));

    if isempty(rmid)
        continue
    else
        obi_patl_rm3 = [obi_patl_rm3;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
obi_patl_sub3 = obi_patl_sub2;
obi_patl_sub3(obi_patl_rm3,:) = [];


% %% Rename all finalized subsets as '_fin'
lit_patl_fin = lit_pyra_patl;
jdi_patl_fin = jdi_patl_sub1;
gbf_patl_fin = gbf_patl_sub2;
obi_patl_fin = obi_patl_sub3;


%% ======= Step 3: P. aherniosum =======
% Lit > OBIS
% %%%% 3a: Lit vs. OBIS
obi_pahe_rm1 = [];
for l=1:height(lit_pyra_pahe)
    rmid = find(abs(lit_pyra_pahe.Lat_dec(l)-obi_pyra_pahe.Lat_dec)<0.1 & ...
                 abs(lit_pyra_pahe.Lon_dec(l)-obi_pyra_pahe.Lon_dec)<0.1 & ...
                 (lit_pyra_pahe.Year(l) == obi_pyra_pahe.Year));
                 % (lit_pyra_pahe.Month(l) == obi_pyra_pahe.Month));

    if isempty(rmid)
        continue
    else
        obi_pahe_rm1 = [obi_pahe_rm1;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
obi_pahe_sub1 = obi_pyra_pahe;
obi_pahe_sub1(obi_pahe_rm1,:) = [];

% %% Rename all finalized subsets as '_fin'
lit_pahe_fin = lit_pyra_pahe;
obi_pahe_fin = obi_pahe_sub1;


%% ======= Step 4: P. ovatum =======
obi_pova_fin = obi_pyra_pova;


%% ======= Step 5: Pyrostremma spp. =======
gbf_tspp_fin = gbf_pyrt_tspp;


%% ======= Step 6: Pr. spinosum =======
% Lit > JeDI > GBIF > OBIS

% %%%% 6a: Lit vs. all DBs
% %% Lit vs. JeDI
jdi_tspi_rm1 = [];
for l=1:height(lit_pyrt_tspi)
    rmid = find(abs(lit_pyrt_tspi.Lat_dec(l)-jdi_pyrt_tspi.Lat_dec)<0.1 & ...
                 abs(lit_pyrt_tspi.Lon_dec(l)-jdi_pyrt_tspi.Lon_dec)<0.1 & ...
                 (lit_pyrt_tspi.Year(l) == jdi_pyrt_tspi.Year) & ...
                 (lit_pyrt_tspi.Month(l) == jdi_pyrt_tspi.Month));
    if isempty(rmid)
        continue
    else
        jdi_tspi_rm1 = [jdi_tspi_rm1;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
jdi_tspi_sub1 = jdi_pyrt_tspi;
jdi_tspi_sub1(jdi_tspi_rm1,:) = [];


% %% Lit vs. GBIF
gbf_tspi_rm1 = [];
for l=1:height(lit_pyrt_tspi)
    rmid = find(abs(lit_pyrt_tspi.Lat_dec(l)-gbf_pyrt_tspi.Lat_dec)<0.1 & ...
                 abs(lit_pyrt_tspi.Lon_dec(l)-gbf_pyrt_tspi.Lon_dec)<0.1 & ...
                 (lit_pyrt_tspi.Year(l) == gbf_pyrt_tspi.Year) & ...
                 (lit_pyrt_tspi.Month(l) == gbf_pyrt_tspi.Month));
    if isempty(rmid)
        continue
    else
        gbf_tspi_rm1 = [gbf_tspi_rm1;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
gbf_tspi_sub1 = gbf_pyrt_tspi;
gbf_tspi_sub1(gbf_tspi_rm1,:) = [];


% %% Lit vs. OBIS
obi_tspi_rm1 = [];
for l=1:height(lit_pyrt_tspi)
    rmid = find(abs(lit_pyrt_tspi.Lat_dec(l)-obi_pyrt_tspi.Lat_dec)<0.1 & ...
                 abs(lit_pyrt_tspi.Lon_dec(l)-obi_pyrt_tspi.Lon_dec)<0.1 & ...
                 (lit_pyrt_tspi.Year(l) == obi_pyrt_tspi.Year));
                 % (lit_pyrt_tspi.Month(l) == obi_pyrt_tspi.Month));

    if isempty(rmid)
        continue
    else
        obi_tspi_rm1 = [obi_tspi_rm1;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
obi_tspi_sub1 = obi_pyrt_tspi;
obi_tspi_sub1(obi_tspi_rm1,:) = [];


% %%%% 6b: JeDI (sub1) vs. remaining DBs (sub1) 
% %% JeDI vs. GBIF
% First, get all indices in secondary array that overlap with primary array
gbf_tspi_rm2 = [];
for l=1:height(jdi_tspi_sub1)
    rmid = find(abs(jdi_tspi_sub1.Lat_dec(l)-gbf_tspi_sub1.Lat_dec)<0.1 & ...
                 abs(jdi_tspi_sub1.Lon_dec(l)-gbf_tspi_sub1.Lon_dec)<0.1 & ...
                 (jdi_tspi_sub1.Year(l) == gbf_tspi_sub1.Year) & ...
                 (jdi_tspi_sub1.Month(l) == gbf_tspi_sub1.Month));
    if isempty(rmid)
        continue
    else
        gbf_tspi_rm2 = [gbf_tspi_rm2;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
gbf_tspi_sub2 = gbf_tspi_sub1;
gbf_tspi_sub2(gbf_tspi_rm2,:) = [];


% %% JeDI vs. OBIS
obi_tspi_rm2 = [];
for l=1:height(jdi_tspi_sub1)
    rmid = find(abs(jdi_tspi_sub1.Lat_dec(l)-obi_tspi_sub1.Lat_dec)<0.1 & ...
                 abs(jdi_tspi_sub1.Lon_dec(l)-obi_tspi_sub1.Lon_dec)<0.1 & ...
                 (jdi_tspi_sub1.Year(l) == obi_tspi_sub1.Year));
                 % (jdi_tspi_sub1.Month(l) == obi_tspi_sub1.Month));
    if isempty(rmid)
        continue
    else
        obi_tspi_rm2 = [obi_tspi_rm2;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
obi_tspi_sub2 = obi_tspi_sub1;
obi_tspi_sub2(obi_tspi_rm2,:) = [];


% %%%% 6c: GBIF (sub2) vs. OBIS (sub2)
obi_tspi_rm3 = [];
for l=1:height(gbf_tspi_sub2)
    rmid = find(abs(gbf_tspi_sub2.Lat_dec(l)-obi_tspi_sub2.Lat_dec)<0.1 & ...
                 abs(gbf_tspi_sub2.Lon_dec(l)-obi_tspi_sub2.Lon_dec)<0.1 & ...
                 (gbf_tspi_sub2.Year(l) == obi_tspi_sub2.Year));
                 % (gbf_tspi_sub2.Month(l) == obi_tspi_sub2.Month));
 
    if isempty(rmid)
        continue
    else
        obi_tspi_rm3 = [obi_tspi_rm3;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
obi_tspi_sub3 = obi_tspi_sub2;
obi_tspi_sub3(obi_tspi_rm3,:) = [];


% %% Rename all finalized subsets as '_fin'
lit_tspi_fin = lit_pyrt_tspi;
jdi_tspi_fin = jdi_tspi_sub1;
gbf_tspi_fin = gbf_tspi_sub2;
obi_tspi_fin = obi_tspi_sub3;


%% ======= Step 7: Pr. agassizi =======
% JeDI > GBIF > OBIS

% %%%% 7a: JeDI vs. other DBs
% %% JeDI vs. GBIF
gbf_taga_rm1 = [];
for l=1:height(jdi_pyrt_taga)
    rmid = find(abs(jdi_pyrt_taga.Lat_dec(l)-gbf_pyrt_taga.Lat_dec)<0.1 & ...
                 abs(jdi_pyrt_taga.Lon_dec(l)-gbf_pyrt_taga.Lon_dec)<0.1 & ...
                 (jdi_pyrt_taga.Year(l) == gbf_pyrt_taga.Year) & ...
                 (jdi_pyrt_taga.Month(l) == gbf_pyrt_taga.Month));
    if isempty(rmid)
        continue
    else
        gbf_taga_rm1 = [gbf_taga_rm1;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
gbf_taga_sub1 = gbf_pyrt_taga;
gbf_taga_sub1(gbf_taga_rm1,:) = [];


% %% JeDI vs. OBIS
obi_taga_rm1 = [];
for l=1:height(jdi_pyrt_taga)
    rmid = find(abs(jdi_pyrt_taga.Lat_dec(l)-obi_pyrt_taga.Lat_dec)<0.1 & ...
                 abs(jdi_pyrt_taga.Lon_dec(l)-obi_pyrt_taga.Lon_dec)<0.1 & ...
                 (jdi_pyrt_taga.Year(l) == obi_pyrt_taga.Year));
                 % (jdi_pyrt_taga.Month(l) == obi_pyrt_taga.Month));
             
    if isempty(rmid)
        continue
    else
        obi_taga_rm1 = [obi_taga_rm1;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
obi_taga_sub1 = obi_pyrt_taga;
obi_taga_sub1(obi_taga_rm1,:) = [];


% %%%% 7b: GBIF (sub1) vs. OBIS (sub1)
obi_taga_rm2 = [];
for l=1:height(gbf_taga_sub1)
    rmid = find(abs(gbf_taga_sub1.Lat_dec(l)-obi_taga_sub1.Lat_dec)<0.1 & ...
                 abs(gbf_taga_sub1.Lon_dec(l)-obi_taga_sub1.Lon_dec)<0.1 & ...
                 (gbf_taga_sub1.Year(l) == obi_taga_sub1.Year));
                 % (gbf_taga_sub1.Month(l) == obi_taga_sub1.Month));
        
    if isempty(rmid)
        continue
    else
        obi_taga_rm2 = [obi_taga_rm2;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
obi_taga_sub2 = obi_taga_sub1;
obi_taga_sub2(obi_taga_rm2,:) = [];

% %% Rename all finalized subsets as '_fin'
jdi_taga_fin = jdi_pyrt_taga;
gbf_taga_fin = gbf_taga_sub1;
obi_taga_fin = obi_taga_sub2;



%% ======= Step 8: Pyrosomella spp. =======
% GBIF > OBIS
% %%%% 8a: GBIF vs. OBIS
obi_lspp_rm1 = [];
for l=1:height(gbf_pyrl_lspp)
    rmid = find(abs(gbf_pyrl_lspp.Lat_dec(l)-obi_pyrl_lspp.Lat_dec)<0.1 & ...
                 abs(gbf_pyrl_lspp.Lon_dec(l)-obi_pyrl_lspp.Lon_dec)<0.1 & ...
                 (gbf_pyrl_lspp.Year(l) == obi_pyrl_lspp.Year));
                 % (gbf_pyrl_lspp.Month(l) == obi_pyrl_lspp.Month));
           
    if isempty(rmid)
        continue
    else
        obi_lspp_rm1 = [obi_lspp_rm1;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
obi_lspp_sub1 = obi_pyrl_lspp;
obi_lspp_sub1(obi_lspp_rm1,:) = [];


% %% Rename all finalized subsets as '_fin'
gbf_lspp_fin = gbf_pyrl_lspp;
obi_lspp_fin = obi_lspp_sub1;



%% ======= Step 9: Pl. verticillata =======
% Lit > JeDI > GBIF > OBIS

% %%%% 9a: Lit vs. all DBs
% %% Lit vs. JeDI
jdi_lver_rm1 = [];
for l=1:height(lit_pyrl_lver)
    rmid = find(abs(lit_pyrl_lver.Lat_dec(l)-jdi_pyrl_lver.Lat_dec)<0.1 & ...
                 abs(lit_pyrl_lver.Lon_dec(l)-jdi_pyrl_lver.Lon_dec)<0.1 & ...
                 (lit_pyrl_lver.Year(l) == jdi_pyrl_lver.Year) & ...
                 (lit_pyrl_lver.Month(l) == jdi_pyrl_lver.Month));
    if isempty(rmid)
        continue
    else
        jdi_lver_rm1 = [jdi_lver_rm1;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
jdi_lver_sub1 = jdi_pyrl_lver;
jdi_lver_sub1(jdi_lver_rm1,:) = [];


% %% Lit vs. GBIF
gbf_lver_rm1 = [];
for l=1:height(lit_pyrl_lver)
    rmid = find(abs(lit_pyrl_lver.Lat_dec(l)-gbf_pyrl_lver.Lat_dec)<0.1 & ...
                 abs(lit_pyrl_lver.Lon_dec(l)-gbf_pyrl_lver.Lon_dec)<0.1 & ...
                 (lit_pyrl_lver.Year(l) == gbf_pyrl_lver.Year) & ...
                 (lit_pyrl_lver.Month(l) == gbf_pyrl_lver.Month));
    if isempty(rmid)
        continue
    else
        gbf_lver_rm1 = [gbf_lver_rm1;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
gbf_lver_sub1 = gbf_pyrl_lver;
gbf_lver_sub1(gbf_lver_rm1,:) = [];


% %% Lit vs. OBIS
obi_lver_rm1 = [];
for l=1:height(lit_pyrl_lver)
    rmid = find(abs(lit_pyrl_lver.Lat_dec(l)-obi_pyrl_lver.Lat_dec)<0.1 & ...
                 abs(lit_pyrl_lver.Lon_dec(l)-obi_pyrl_lver.Lon_dec)<0.1 & ...
                 (lit_pyrl_lver.Year(l) == obi_pyrl_lver.Year));
                 % (lit_pyrl_lver.Month(l) == obi_pyrl_lver.Month));
             
    if isempty(rmid)
        continue
    else
        obi_lver_rm1 = [obi_lver_rm1;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
obi_lver_sub1 = obi_pyrl_lver;
obi_lver_sub1(obi_lver_rm1,:) = [];


% %%%% 9b: JeDI (sub1) vs. remaining DBs (sub1) 
% %% JeDI vs. GBIF
% First, get all indices in secondary array that overlap with primary array
gbf_lver_rm2 = [];
for l=1:height(jdi_lver_sub1)
    rmid = find(abs(jdi_lver_sub1.Lat_dec(l)-gbf_lver_sub1.Lat_dec)<0.1 & ...
                 abs(jdi_lver_sub1.Lon_dec(l)-gbf_lver_sub1.Lon_dec)<0.1 & ...
                 (jdi_lver_sub1.Year(l) == gbf_lver_sub1.Year) & ...
                 (jdi_lver_sub1.Month(l) == gbf_lver_sub1.Month));
    if isempty(rmid)
        continue
    else
        gbf_lver_rm2 = [gbf_lver_rm2;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
gbf_lver_sub2 = gbf_lver_sub1;
gbf_lver_sub2(gbf_lver_rm2,:) = [];


% %% JeDI vs. OBIS
obi_lver_rm2 = [];
for l=1:height(jdi_lver_sub1)
    rmid = find(abs(jdi_lver_sub1.Lat_dec(l)-obi_lver_sub1.Lat_dec)<0.1 & ...
                 abs(jdi_lver_sub1.Lon_dec(l)-obi_lver_sub1.Lon_dec)<0.1 & ...
                 (jdi_lver_sub1.Year(l) == obi_lver_sub1.Year));
                 % (jdi_lver_sub1.Month(l) == obi_lver_sub1.Month));
          
    if isempty(rmid)
        continue
    else
        obi_lver_rm2 = [obi_lver_rm2;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
obi_lver_sub2 = obi_lver_sub1;
obi_lver_sub2(obi_lver_rm2,:) = [];


% %%%% 9c: GBIF (sub2) vs. OBIS (sub2)
obi_lver_rm3 = [];
for l=1:height(gbf_lver_sub2)
    rmid = find(abs(gbf_lver_sub2.Lat_dec(l)-obi_lver_sub2.Lat_dec)<0.1 & ...
                 abs(gbf_lver_sub2.Lon_dec(l)-obi_lver_sub2.Lon_dec)<0.1 & ...
                 (gbf_lver_sub2.Year(l) == obi_lver_sub2.Year));
                 % (gbf_lver_sub2.Month(l) == obi_lver_sub2.Month));
          
    if isempty(rmid)
        continue
    else
        obi_lver_rm3 = [obi_lver_rm3;rmid];
    end
end
% Second, *remove* those duplicates from secondary array -> create 'Subset #1'
obi_lver_sub3 = obi_lver_sub2;
obi_lver_sub3(obi_lver_rm3,:) = [];


% %% Rename all finalized subsets as '_fin'
lit_lver_fin = lit_pyrl_lver;
jdi_lver_fin = jdi_lver_sub1;
gbf_lver_fin = gbf_lver_sub2;
obi_lver_fin = obi_lver_sub3;

