%%%%%%%%%%%%%%
%%% Codes for: 
%%%     Lilly et al. (in review). A Global Review of Pyrosomes:  
%%%     Shedding light on the ocean’s elusive gelatinous ‘fire-bodies’

% %% Part 2: Divide into species-level groupings for: i) JeDI, ii) GBIF



%% ======= Part 1: JeDI Groupings ========        
% %% JeDI       
% 1a: Get species names for species-level plotting on map
jdipyro_sppunq = unique(jdi_pyro_arr.Rank_Species,'rows');

% 1b: JeDI - Delineate sub-variables for 5 groups
% 1)'Pyrosoma spp.'
jdi_pspp = jdi_pyro_arr(find(strcmp(jdi_pyro_arr.Rank_Species,{jdipyro_sppunq(6,:)})),:);
% 2) 'Pyrosoma atlanticum'
jdi_patl = [jdi_pyro_arr(find(strcmp(jdi_pyro_arr.Rank_Species,{jdipyro_sppunq(2,:)})),:);
            jdi_pyro_arr(find(strcmp(jdi_pyro_arr.Rank_Species,{jdipyro_sppunq(3,:)})),:);
            jdi_pyro_arr(find(strcmp(jdi_pyro_arr.Rank_Species,{jdipyro_sppunq(4,:)})),:);
            jdi_pyro_arr(find(strcmp(jdi_pyro_arr.Rank_Species,{jdipyro_sppunq(5,:)})),:);
            jdi_pyro_arr(find(strcmp(jdi_pyro_arr.Rank_Species,{jdipyro_sppunq(7,:)})),:)];
% 3) 'Pyrostremma agassizi'
jdi_taga = jdi_pyro_arr(find(strcmp(jdi_pyro_arr.Rank_Species,{jdipyro_sppunq(1,:)})),:);
% 4) 'Pyrostremma spinosum'
jdi_tspi = jdi_pyro_arr(find(strcmp(jdi_pyro_arr.Rank_Species,{jdipyro_sppunq(8,:)})),:);
% 5) 'Pyrosomella verticillata'
jdi_lver = jdi_pyro_arr(find(strcmp(jdi_pyro_arr.Rank_Species,{jdipyro_sppunq(9,:)})),:);



%% ======= Part 2: GBIF Groupings ======== 
% %% 2a: Pyrosoma
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


% %% 2b: Pyrostremma
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


% %% 2c: Pyrosomella
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


