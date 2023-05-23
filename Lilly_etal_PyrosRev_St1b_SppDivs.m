%%%%%%%%%%%%%%
%%% Codes for: 
%%%     Lilly et al. (in review). A Global Review of Pyrosomes:  
%%%     Shedding light on the ocean’s elusive gelatinous ‘fire-bodies’

% %% Part 2: Divide into species-level groupings for: i) Literaturer, 
%            ii) JeDI, iii) GBIF, iv) OBIS



%% ======= Part 1: Literature - spp-level groupings ======== 
% 1a: Get list of unique species
litpyro_sppunq = unique(lit_pyro_all.Species);

% 1b: Delineate sub-variables for each species group
% 1)'Pyrosoma spp.'
lit_pyra_pspp = lit_pyro_all(find(strcmp(lit_pyro_all.Species,litpyro_sppunq{3,:})),:);
% 2)'P. atlanticum'
lit_pyra_patl = lit_pyro_all(find(strcmp(lit_pyro_all.Species,litpyro_sppunq{2,:})),:);
% 3)'P. aherniosum'
lit_pyra_pahe = lit_pyro_all(find(strcmp(lit_pyro_all.Species,litpyro_sppunq{1,:})),:);
% 4)'Pr. spinosum'
lit_pyrt_tspi = lit_pyro_all(find(strcmp(lit_pyro_all.Species,litpyro_sppunq{5,:})),:);
% 5)'Pl. verticillata'
lit_pyrl_lver = lit_pyro_all(find(strcmp(lit_pyro_all.Species,litpyro_sppunq{4,:})),:);



%% ======= Part 2: JeDI - spp-level groupings ========            
% 2a: Get species names for species-level plotting on map
jdipyro_sppunq = unique(char(jdi_pyro_arr.Rank_Species),'rows');

% 2b: Delineate sub-variables for 5 groups
% 1)'Pyrosoma spp.'
jdi_pyra_pspp = jdi_pyro_arr(find(strcmp(jdi_pyro_arr.Rank_Species,{jdipyro_sppunq(6,:)})),:);
% 2) 'Pyrosoma atlanticum'
jdi_pyra_patl = [jdi_pyro_arr(find(strcmp(jdi_pyro_arr.Rank_Species,{jdipyro_sppunq(2,:)})),:);
            jdi_pyro_arr(find(strcmp(jdi_pyro_arr.Rank_Species,{jdipyro_sppunq(3,:)})),:);
            jdi_pyro_arr(find(strcmp(jdi_pyro_arr.Rank_Species,{jdipyro_sppunq(4,:)})),:);
            jdi_pyro_arr(find(strcmp(jdi_pyro_arr.Rank_Species,{jdipyro_sppunq(5,:)})),:);
            jdi_pyro_arr(find(strcmp(jdi_pyro_arr.Rank_Species,{jdipyro_sppunq(7,:)})),:)];
% 3) 'Pyrostremma agassizi'
jdi_pyrt_taga = jdi_pyro_arr(find(strcmp(jdi_pyro_arr.Rank_Species,{jdipyro_sppunq(1,:)})),:);
% 4) 'Pyrostremma spinosum'
jdi_pyrt_tspi = jdi_pyro_arr(find(strcmp(jdi_pyro_arr.Rank_Species,{jdipyro_sppunq(8,:)})),:);
% 5) 'Pyrosomella verticillata'
jdi_pyrl_lver = jdi_pyro_arr(find(strcmp(jdi_pyro_arr.Rank_Species,{jdipyro_sppunq(9,:)})),:);



%% ======= Part 3: GBIF - spp-level groupings ======== 
% %% 3a: Pyrosoma
% Get categories of unique species
gbif_sppunq_pyra = unique(gbiftbl_r.Sci_name_verbatim);

% Delineate spp-level groups
% 1) 'Pyrosoma spp.'
gbf_pyra_pspp = [];
for p=[1:4,49:52]
    pspp = gbiftbl_r(find(strcmp(gbiftbl_r.Sci_name_verbatim,gbif_sppunq_pyra(p,:))),:);
    gbf_pyra_pspp = [gbf_pyra_pspp;pspp];
end
% 2) 'Pyrosoma atlanticum'
gbf_pyra_patl = [];
for a=[10:32,34:42,44,48]
    patl = gbiftbl_r(find(strcmp(gbiftbl_r.Sci_name_verbatim,gbif_sppunq_pyra(a,:))),:);
    gbf_pyra_patl = [gbf_pyra_patl;patl];
end
% 3) 'Pyrosoma aherniosum'
gbf_pyra_pahe = [];
for h=[5:9]
    pahe = gbiftbl_r(find(strcmp(gbiftbl_r.Sci_name_verbatim,gbif_sppunq_pyra(h,:))),:);
    gbf_pyra_pahe = [gbf_pyra_pahe;pahe];
end
% 4) 'Pyrosoma godeauxi'
gbf_pyra_pgod = [];
for g=[43]
    pgod = gbiftbl_r(find(strcmp(gbiftbl_r.Sci_name_verbatim,gbif_sppunq_pyra(g,:))),:);
    gbf_pyra_pgod = [gbf_pyra_pgod;pgod];
end 
% 5) 'Pyrosoma ovatum'
gbf_pyra_pova = [];
for o =[45:47]
    pova = gbiftbl_r(find(strcmp(gbiftbl_r.Sci_name_verbatim,gbif_sppunq_pyra(o,:))),:);
    gbf_pyra_pova = [gbf_pyra_pova;pova];
end 


% %% 3b: Pyrostremma
% Get categories of unique species
gbif_sppunq_pyrt = unique(gbiftbl_t.Sci_name_verbatim);

% Delineate spp-level groups for 'Pyrostremma'
% 1) 'Pyrostremma spp.'
gbf_pyrt_tspp = [];
for t=[1,10]
    tspp = gbiftbl_t(find(strcmp(gbiftbl_t.Sci_name_verbatim,gbif_sppunq_pyrt(t,:))),:);
    gbf_pyrt_tspp = [gbf_pyrt_tspp;tspp];
end
% 2) 'Pyrostremma agassizi'
gbf_pyrt_taga = [];
for z =[3:6,11:12]
    taga = gbiftbl_t(find(strcmp(gbiftbl_t.Sci_name_verbatim,gbif_sppunq_pyrt(z,:))),:);
    gbf_pyrt_taga = [gbf_pyrt_taga;taga];
end
% 3) 'Pyrostremma spinosum'
gbf_pyrt_tspi = [];
for s =[2,7:9,13:14]
    tspi = gbiftbl_t(find(strcmp(gbiftbl_t.Sci_name_verbatim,gbif_sppunq_pyrt(s,:))),:);
    gbf_pyrt_tspi = [gbf_pyrt_tspi;tspi];
end


% %% 3c: Pyrosomella
% Get categories of unique species
gbif_sppunq_pyrl = unique(gbiftbl_l.Sci_name_verbatim);

% Delineate spp-level groups for 'Pyrosomella'
% 1) 'Pyrosomella spp.'
gbf_pyrl_lspp = [];
for l=[7:10]
    lspp = gbiftbl_l(find(strcmp(gbiftbl_l.Sci_name_verbatim,gbif_sppunq_pyrl(l,:))),:);
    gbf_pyrl_lspp = [gbf_pyrl_lspp;lspp];
end
% 2) 'Pyrosomella verticillata'
gbf_pyrl_lver = [];
for v=[1:6,11:12]
    lver = gbiftbl_l(find(strcmp(gbiftbl_l.Sci_name_verbatim,gbif_sppunq_pyrl(v,:))),:);
    gbf_pyrl_lver = [gbf_pyrl_lver;lver];
end



%% ======= Part 4: OBIS - spp-level groupings ======== 
% Get categories of unique species
obi_sppunq = unique(obitbl.Scientific_name);
% obs_sppunqorg = unique(obstbl.Original_scientific_name); % Entire list of all OLD names

% Delineate spp-level groups
% 1) 'Pyrosoma spp.'
obi_pyrosomatid = obitbl(find(strcmp(obitbl.Scientific_name,obi_sppunq(5,:))),:);
obi_pyra_pspp = [obitbl(find(strcmp(obitbl.Scientific_name,obi_sppunq(1,:))),:);
                 obitbl(find(strcmp(obitbl.Scientific_name,obi_sppunq(5,:))),:)];
% 2) 'Pyrosoma atlanticum'
obi_pyra_patl = obitbl(find(strcmp(obitbl.Scientific_name,obi_sppunq(3,:))),:);
% 3) 'Pyrosoma aherniosum'
obi_pyra_pahe = obitbl(find(strcmp(obitbl.Scientific_name,obi_sppunq(2,:))),:);
% 4) 'Pyrosoma ovatum'
obi_pyra_pova = obitbl(find(strcmp(obitbl.Scientific_name,obi_sppunq(4,:))),:);
% 5) 'Pyrosomella spp.'
obi_pyrl_lspp = obitbl(find(strcmp(obitbl.Scientific_name,obi_sppunq(6,:))),:);
% 6) 'Pyrosomella verticillata'
obi_pyrl_lver = obitbl(find(strcmp(obitbl.Scientific_name,obi_sppunq(7,:))),:);
% 7) 'Pyrostremma agassizi'
obi_pyrt_taga = obitbl(find(strcmp(obitbl.Scientific_name,obi_sppunq(8,:))),:);
% 8) 'Pyrostremma spinosum'
obi_pyrt_tspi = obitbl(find(strcmp(obitbl.Scientific_name,obi_sppunq(9,:))),:);


