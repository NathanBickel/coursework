%% Submission by Nathan Bickel

%% This suppresses some warning messages
%% from the interpretor. 
:- discontiguous
       
       %% released(Movie, Year): 
       %% Movie is released in Year. 
       released/2,
       
       %% acted_in(Actor/Actress, Movie):
       %% Actor/Actress acted in Movie.
       acted_in/2,

       %% directed(Movie, Director)
       %% Movie is directed by Director. 
       directed/2,

       %% Movie was starring Actor/Actress as Role. 
       %% starring_as(Movie, Actor/Actress, Role)
       %% We will not be using starring_as/3.
       starring_as/3. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% In this homework, you are asked to provide the missing queries for 
%% Question 1-10. Your programs and
%% queries must be self-contained: only using released/2, acted_in/2,
%% directed/2, equality, negation, and the predicates you defined 
%% yourself. For your convience, you may also use
%% distinct/1, print/1, nl/0 and fail/0 in your queries.
%% For example: distinct(query(Y)), print(Y), nl, fail. When in
%% doubt, please contact me. 

%% You must replace "undefined" with your own
%% queries. Auxillary predicates are optional,
%% they may be helpful for making your queries shorter.
%% Here is an example of how to write your solution.

%% Question 0. Who directed barton_fink?

%% Auxillary predicates (optional):
direct_barton_fink(X) :- directed(barton_fink, X).

%% Queries for Question 0.
query0 :- distinct(direct_barton_fink(X)), print(X), nl, fail.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Note: Your file must be loaded by swi-prolog
%% interpretor and it should be free of error messages. You will
%% get 0 point for your homework if your file has any error messages when
%% it is loaded. 
%% It is OK if you have some warning messages. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Homework 2.

%% Question 1. Did bill_murray act in lost_in_translation? (2 points)

%% Auxillary predicates (optional): 

%% Queries for Question 1, please replace "undefined" with your query. 
query1 :- acted_in(bill_murray, lost_in_translation). 

%% Question 2. Who directed blade_runner? (2 points)

%% Auxillary predicates (optional):

%% Queries for Question 2, please replace "undefined" with your query. 
query2 :- distinct(directed(blade_runner, X)), print(X), nl, fail.

%% Question 3. Did anyone act in both home_alone_3 and north? (2 points)

%% Auxillary predicates (optional):
acted_in_both(X, Y, Z) :- acted_in(X, Y), acted_in(X, Z). 

%% Queries for Question 3, please replace "undefined" with your query. 
query3 :- distinct(acted_in_both(X, home_alone_3, north)), print(X), nl, fail. 

%% Question 4. Was there a movie released in 1990 that did not feature al_pacino? (2 points)

%% Auxillary predicates (optional):
movie_without_actor_in_year(M, A, Y) :- released(M, Y), \+ acted_in(A, M).

%% Queries for Question 4, please replace "undefined" with your query. 
query4 :- distinct(movie_without_actor_in_year(X, al_pacino, 1990)), print(X), nl, fail. 

%% Question 5. Who directed movies released in 2004? (2 points)

%% Auxillary predicates (optional):
directed_movie_in(D, Y) :- directed(M, D), released(M, Y).

%% Queries for Question 5, please replace "undefined" with your query. 
query5 :- distinct(directed_movie_in(X, 2004)), print(X), nl, fail.

%% Question 6. Has anyone directed more than 2 movies? (3 points)

%% Auxillary predicates (optional):
distinct_a_b_c(A, B, C) :- \+ A == B, \+ A == C, \+ B == C.
directed_a_b_c(D, A, B, C) :- directed(A, D), directed(B, D), directed(C, D), distinct_a_b_c(A, B, C).
directed_more_than_two(D) :- directed_a_b_c(D, A, B, C).

%% Queries for Question 6, please replace "undefined" with your query. 
query6 :- distinct(directed_more_than_two(X)), print(X), nl, fail. 

%% Question 7. Does any movie have more than one director? (3 points)

%% Auxillary predicates (optional):
directed_by_a_b(M, A, B) :- directed(M, A), directed(M, B), \+ A == B.
directed_by_more_than_one(M) :- directed_by_a_b(M, A, B).

%% Queries for Question 7, please replace "undefined" with your query. 
query7 :- distinct(directed_by_more_than_one(X)), print(X), nl, fail. 

%% Question 8. Has anyone acted in more than one movie released in 2006? (3 points)

%% Auxillary predicates (optional):
acted_in_movie_in_year(A, M, Y) :- acted_in(A, M), released(M, Y).
acted_in_more_than_one_movie_in(A, Y) :- acted_in_movie_in_year(A, M, Y), acted_in_movie_in_year(A, N, Y), \+ M == N.

%% Queries for Question 8, please replace "undefined" with your query. 
query8 :- distinct(acted_in_more_than_one_movie_in(X, 2006)), print(X), nl, fail. 

%% Question 9. Has anyone acted in more than two movies in the same year? (3 points)

%% Auxillary predicates (optional):
acted_in_more_than_two_movies_in_same_year(A) :- acted_in_movie_in_year(A, M, Y), acted_in_movie_in_year(A, N, Y), acted_in_movie_in_year(A, P, Y), distinct_a_b_c(M, N, P). 

%% Queries for Question 9, please replace "undefined" with your query. 
query9 :- distinct(acted_in_more_than_two_movies_in_same_year(X)), print(X), nl, fail.

%% Question 10. Who has worked with the same director in different years? (3 points)

%% Auxillary predicates (optional):
worked_with_director_in_year(A, D, Y) :- acted_in(A, M), directed(M, D), released(M, Y).
worked_with_director_in_different_years(A) :- worked_with_director_in_year(A, D, Y), worked_with_director_in_year(A, D, Z), \+ Y == Z.

%% Queries for Question 10, please replace "undefined" with your query. 
query10 :- distinct(worked_with_director_in_different_years(X)), print(X), nl, fail. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% A movie database
%% Note: do not modify the database below, you will
%% get 0 point if you modify the database below.     

%% A convenient predicate to say "X acted in Y". 
acted_in(X, Y) :- starring_as(Y, X, _). 

released(american_beauty, 1999).
directed(american_beauty, sam_mendes).
starring_as(american_beauty, kevin_spacey, lester_burnham).
starring_as(american_beauty, annette_bening, carolyn_burnham).
starring_as(american_beauty, thora_birch, jane_burnham).
starring_as(american_beauty, wes_bentley, ricky_fitts).
starring_as(american_beauty, mena_suvari, angela_hayes).
starring_as(american_beauty, chris_cooper, col_frank_fitts_usmc).
starring_as(american_beauty, peter_gallagher, buddy_kane).
starring_as(american_beauty, allison_janney, barbara_fitts).
starring_as(american_beauty, scott_bakula, jim_olmeyer).
starring_as(american_beauty, sam_robards, jim_berkley).
starring_as(american_beauty, barry_del_sherman, brad_dupree).
starring_as(american_beauty, ara_celi, sale_house_woman_1).
starring_as(american_beauty, john_cho, sale_house_man_1).
starring_as(american_beauty, fort_atkinson, sale_house_man_2).
starring_as(american_beauty, sue_casey, sale_house_woman_2).
starring_as(american_beauty, kent_faulcon, sale_house_man_3).
starring_as(american_beauty, brenda_wehle, sale_house_woman_4).
starring_as(american_beauty, lisa_cloud, sale_house_woman_5).
starring_as(american_beauty, alison_faulk, spartanette_1).
starring_as(american_beauty, krista_goodsitt, spartanette_2).
starring_as(american_beauty, lily_houtkin, spartanette_3).
starring_as(american_beauty, carolina_lancaster, spartanette_4).
starring_as(american_beauty, romana_leah, spartanette_5).
starring_as(american_beauty, chekeshka_van_putten, spartanette_6).
starring_as(american_beauty, emily_zachary, spartanette_7).
starring_as(american_beauty, nancy_anderson, spartanette_8).
starring_as(american_beauty, reshma_gajjar, spartanette_9).
starring_as(american_beauty, stephanie_rizzo, spartanette_10).
starring_as(american_beauty, heather_joy_sher, playground_girl_1).
starring_as(american_beauty, chelsea_hertford, playground_girl_2).
starring_as(american_beauty, amber_smith, christy_kane).
starring_as(american_beauty, joel_mccrary, catering_boss).
starring_as(american_beauty, marissa_jaret_winokur, mr_smiley_s_counter_girl).
starring_as(american_beauty, dennis_anderson, mr_smiley_s_manager).
starring_as(american_beauty, matthew_kimbrough, firing_range_attendant).
starring_as(american_beauty, erin_cathryn_strubbe, young_jane_burnham).
starring_as(american_beauty, elaine_corral_kendall, newscaster).

released(anna, 1987).
directed(anna, yurek_bogayevicz).
starring_as(anna, sally_kirkland, anna).
starring_as(anna, robert_fields, daniel).
starring_as(anna, paulina_porizkova, krystyna).
starring_as(anna, gibby_brand, director_1).
starring_as(anna, john_robert_tillotson, director_2).
starring_as(anna, julianne_gilliam, woman_author).
starring_as(anna, joe_aufiery, stage_manager).
starring_as(anna, lance_davis, assistant_1).
starring_as(anna, deirdre_o_connell, assistant_2).
starring_as(anna, ruth_maleczech, woman_1_woman_named_gloria).
starring_as(anna, holly_villaire, woman_2_woman_with_bird).
starring_as(anna, shirl_bernheim, woman_3_woman_in_white_veil).
starring_as(anna, ren_e_coleman, woman_4_woman_in_bonnet).
starring_as(anna, gabriela_farrar, woman_5_woman_in_black).
starring_as(anna, jordana_levine, woman_6_woman_in_turban).
starring_as(anna, rosalie_traina, woman_7_woman_in_gold).
starring_as(anna, maggie_wagner, starring_as_d).
starring_as(anna, charles_randall, agent).
starring_as(anna, mimi_weddell, agent_s_secretary).
starring_as(anna, larry_pine, baskin).
starring_as(anna, lola_pashalinski, producer).
starring_as(anna, stefan_schnabel, professor).
starring_as(anna, steven_gilborn, tonda).
starring_as(anna, rand_stone, george).
starring_as(anna, geena_goodwin, daniel_s_mother).
starring_as(anna, david_r_ellis, daniel_s_father).
starring_as(anna, brian_kohn, jonathan).
starring_as(anna, caroline_aaron, interviewer).
starring_as(anna, vasek_simek, czech_demonstrator_1).
starring_as(anna, paul_leski, czech_demonstrator_2).
starring_as(anna, larry_attile, czech_demonstrator_3).
starring_as(anna, sofia_coppola, noodle).
starring_as(anna, theo_mayes, dancing_dishwasher).
starring_as(anna, nina_port, dancing_dishwasher).

released(barton_fink, 1991).
directed(barton_fink, ethan_coen).
directed(barton_fink, joel_coen).
starring_as(barton_fink, john_turturro, barton_fink).
starring_as(barton_fink, john_goodman, charlie_meadows).
starring_as(barton_fink, judy_davis, audrey_taylor).
starring_as(barton_fink, michael_lerner, jack_lipnick).
starring_as(barton_fink, john_mahoney, w_p_mayhew).
starring_as(barton_fink, tony_shalhoub, ben_geisler).
starring_as(barton_fink, jon_polito, lou_breeze).
starring_as(barton_fink, steve_buscemi, chet).
starring_as(barton_fink, david_warrilow, garland_stanford).
starring_as(barton_fink, richard_portnow, detective_mastrionotti).
starring_as(barton_fink, christopher_murney, detective_deutsch).
starring_as(barton_fink, i_m_hobson, derek).
starring_as(barton_fink, meagen_fay, poppy_carnahan).
starring_as(barton_fink, lance_davis, richard_st_claire).
starring_as(barton_fink, harry_bugin, pete).
starring_as(barton_fink, anthony_gordon, maitre_d).
starring_as(barton_fink, jack_denbo, stagehand).
starring_as(barton_fink, max_grod_nchik, clapper_boy).
starring_as(barton_fink, robert_beecher, referee).
starring_as(barton_fink, darwyn_swalve, wrestler).
starring_as(barton_fink, gayle_vance, geisler_s_secretary).
starring_as(barton_fink, johnny_judkins, sailor).
starring_as(barton_fink, jana_marie_hupp, uso_girl).
starring_as(barton_fink, isabelle_townsend, beauty).
starring_as(barton_fink, william_preston_robertson, voice).

released(the_big_lebowski, 1998).
directed(the_big_lebowski, joel_coen).
starring_as(the_big_lebowski, jeff_bridges, jeffrey_lebowski__the_dude).
starring_as(the_big_lebowski, john_goodman, walter_sobchak).
starring_as(the_big_lebowski, julianne_moore, maude_lebowski).
starring_as(the_big_lebowski, steve_buscemi, theodore_donald_donny_kerabatsos).
starring_as(the_big_lebowski, david_huddleston, jeffrey_lebowski__the_big_lebowski).
starring_as(the_big_lebowski, philip_seymour_hoffman, brandt).
starring_as(the_big_lebowski, tara_reid, bunny_lebowski).
starring_as(the_big_lebowski, philip_moon, woo_treehorn_thug).
starring_as(the_big_lebowski, mark_pellegrino, blond_treehorn_thug).
starring_as(the_big_lebowski, peter_stormare, uli_kunkel_nihilist_1__karl_hungus).
starring_as(the_big_lebowski, flea, nihilist_2).
starring_as(the_big_lebowski, torsten_voges, nihilist_3).
starring_as(the_big_lebowski, jimmie_dale_gilmore, smokey).
starring_as(the_big_lebowski, jack_kehler, marty).
starring_as(the_big_lebowski, john_turturro, jesus_quintana).
starring_as(the_big_lebowski, james_g_hoosier, liam_o_brien).
starring_as(the_big_lebowski, carlos_leon, maude_s_thug).
starring_as(the_big_lebowski, terrence_burton, maude_s_thug).
starring_as(the_big_lebowski, richard_gant, older_cop).
starring_as(the_big_lebowski, christian_clemenson, younger_cop).
starring_as(the_big_lebowski, dom_irrera, tony_the_chauffeur).
starring_as(the_big_lebowski, g_rard_l_heureux, lebowski_s_chauffeur).
starring_as(the_big_lebowski, david_thewlis, knox_harrington).
starring_as(the_big_lebowski, lu_elrod, coffee_shop_waitress).
starring_as(the_big_lebowski, mike_gomez, auto_circus_cop).
starring_as(the_big_lebowski, peter_siragusa, gary_the_bartender).
starring_as(the_big_lebowski, sam_elliott, the_stranger).
starring_as(the_big_lebowski, marshall_manesh, doctor).
starring_as(the_big_lebowski, harry_bugin, arthur_digby_sellers).
starring_as(the_big_lebowski, jesse_flanagan, little_larry_sellers).
starring_as(the_big_lebowski, irene_olga_l_pez, pilar_sellers_housekeeper).
starring_as(the_big_lebowski, luis_colina, corvette_owner).
starring_as(the_big_lebowski, ben_gazzara, jackie_treehorn).
starring_as(the_big_lebowski, leon_russom, malibu_police_chief).
starring_as(the_big_lebowski, ajgie_kirkland, cab_driver).
starring_as(the_big_lebowski, jon_polito, da_fino).
starring_as(the_big_lebowski, aimee_mann, nihilist_woman).
starring_as(the_big_lebowski, jerry_haleva, saddam_hussein).
starring_as(the_big_lebowski, jennifer_lamb, pancake_waitress).
starring_as(the_big_lebowski, warren_keith, funeral_director).
starring_as(the_big_lebowski, wendy_braun, chorine_dancer).
starring_as(the_big_lebowski, asia_carrera, sherry_in_logjammin).
starring_as(the_big_lebowski, kiva_dawson, dancer).
starring_as(the_big_lebowski, robin_jones, checker_at_ralph_s).
starring_as(the_big_lebowski, paris_themmen, '').

released(blade_runner, 1997).
directed(blade_runner, joseph_d_kucan).
starring_as(blade_runner, martin_azarow, dino_klein).
starring_as(blade_runner, lloyd_bell, additional_voices).
starring_as(blade_runner, mark_benninghoffen, ray_mccoy).
starring_as(blade_runner, warren_burton, runciter).
starring_as(blade_runner, gwen_castaldi, dispatcher_and_newscaster).
starring_as(blade_runner, signy_coleman, dektora).
starring_as(blade_runner, gary_columbo, general_doll).
starring_as(blade_runner, jason_cottle, luthur_lance_photographer).
starring_as(blade_runner, timothy_dang, izo).
starring_as(blade_runner, gerald_deloff, additional_voices).
starring_as(blade_runner, lisa_edelstein, crystal_steele).
starring_as(blade_runner, gary_l_freeman, additional_voices).
starring_as(blade_runner, jeff_garlin, lieutenant_edison_guzza).
starring_as(blade_runner, eric_gooch, additional_voices).
starring_as(blade_runner, javier_grajeda, gaff).
starring_as(blade_runner, mike_grayford, additional_voices).
starring_as(blade_runner, gloria_hoffmann, mia).
starring_as(blade_runner, james_hong, dr_chew).
starring_as(blade_runner, kia_huntzinger, additional_voices).
starring_as(blade_runner, anthony_izzo, officer_leary).
starring_as(blade_runner, brion_james, leon).
starring_as(blade_runner, shelly_johnson, additional_voices).
starring_as(blade_runner, terry_jourden, spencer_grigorian).
starring_as(blade_runner, jerry_kernion, holloway).
starring_as(blade_runner, joseph_d_kucan, crazylegs_larry).
starring_as(blade_runner, jerry_lan, murray).
starring_as(blade_runner, michael_b_legg, additional_voices).
starring_as(blade_runner, demarlo_lewis, additional_voices).
starring_as(blade_runner, tse_cheng_lo, additional_voices).
starring_as(blade_runner, etsuko_mader, additional_voices).
starring_as(blade_runner, mohanned_mansour, additional_voices).
starring_as(blade_runner, karen_maruyama, fish_dealer).
starring_as(blade_runner, michael_mcshane, marcus_eisenduller).
starring_as(blade_runner, alexander_mervin, sadik).
starring_as(blade_runner, tony_mitch, governor_kolvig).
starring_as(blade_runner, toru_nagai, howie_lee).
starring_as(blade_runner, dwight_k_okahara, additional_voices).
starring_as(blade_runner, gerald_okamura, zuben).
starring_as(blade_runner, bruno_oliver, gordo_frizz).
starring_as(blade_runner, pauley_perrette, lucy_devlin).
starring_as(blade_runner, mark_rolston, clovis).
starring_as(blade_runner, stephen_root, early_q).
starring_as(blade_runner, william_sanderson, j_f_sebastian).
starring_as(blade_runner, vincent_schiavelli, bullet_bob).
starring_as(blade_runner, rosalyn_sidewater, isabella).
starring_as(blade_runner, ron_snow, blimp_announcer).
starring_as(blade_runner, stephen_sorrentino, shoeshine_man_hasan).
starring_as(blade_runner, jessica_straus, answering_machine_female_announcer).
starring_as(blade_runner, melonie_sung, additional_voices).
starring_as(blade_runner, iqbal_theba, moraji).
starring_as(blade_runner, myriam_tubert, insect_dealer).
starring_as(blade_runner, joe_turkel, eldon_tyrell).
starring_as(blade_runner, bill_wade, hanoi).
starring_as(blade_runner, jim_walls, additional_voices).
starring_as(blade_runner, sandra_wang, additional_voices).
starring_as(blade_runner, marc_worden, baker).
starring_as(blade_runner, sean_young, rachael).
starring_as(blade_runner, joe_tippy_zeoli, officer_grayford).

released(blood_simple, 1984).
directed(blood_simple, ethan_coen).
directed(blood_simple, joel_coen).
starring_as(blood_simple, john_getz, ray).
starring_as(blood_simple, frances_mcdormand, abby).
starring_as(blood_simple, dan_hedaya, julian_marty).
starring_as(blood_simple, m_emmet_walsh, loren_visser_private_detective).
starring_as(blood_simple, samm_art_williams, meurice).
starring_as(blood_simple, deborah_neumann, debra).
starring_as(blood_simple, raquel_gavia, landlady).
starring_as(blood_simple, van_brooks, man_from_lubbock).
starring_as(blood_simple, se_or_marco, mr_garcia).
starring_as(blood_simple, william_creamer, old_cracker).
starring_as(blood_simple, loren_bivens, strip_bar_exhorter).
starring_as(blood_simple, bob_mcadams, strip_bar_exhorter).
starring_as(blood_simple, shannon_sedwick, stripper).
starring_as(blood_simple, nancy_finger, girl_on_overlook).
starring_as(blood_simple, william_preston_robertson, radio_evangelist).
starring_as(blood_simple, holly_hunter, helene_trend).
starring_as(blood_simple, barry_sonnenfeld, marty_s_vomiting).

released(the_cotton_club, 1984).
directed(the_cotton_club, francis_ford_coppola).
starring_as(the_cotton_club, richard_gere, michael_dixie_dwyer).
starring_as(the_cotton_club, gregory_hines, sandman_williams).
starring_as(the_cotton_club, diane_lane, vera_cicero).
starring_as(the_cotton_club, lonette_mckee, lila_rose_oliver).
starring_as(the_cotton_club, bob_hoskins, owney_madden).
starring_as(the_cotton_club, james_remar, dutch_schultz).
starring_as(the_cotton_club, nicolas_cage, vincent_dwyer).
starring_as(the_cotton_club, allen_garfield, abbadabba_berman).
starring_as(the_cotton_club, fred_gwynne, frenchy_demange).
starring_as(the_cotton_club, gwen_verdon, tish_dwyer).
starring_as(the_cotton_club, lisa_jane_persky, frances_flegenheimer).
starring_as(the_cotton_club, maurice_hines, clay_williams).
starring_as(the_cotton_club, julian_beck, sol_weinstein).
starring_as(the_cotton_club, novella_nelson, madame_st_clair).
starring_as(the_cotton_club, laurence_fishburne, bumpy_rhodes).
starring_as(the_cotton_club, john_p_ryan, joe_flynn).
starring_as(the_cotton_club, tom_waits, irving_stark).
starring_as(the_cotton_club, ron_karabatsos, mike_best).
starring_as(the_cotton_club, glenn_withrow, ed_popke).
starring_as(the_cotton_club, jennifer_grey, patsy_dwyer).
starring_as(the_cotton_club, wynonna_smith, winnie_williams).
starring_as(the_cotton_club, thelma_carpenter, norma_williams).
starring_as(the_cotton_club, charles_honi_coles, suger_coates).
starring_as(the_cotton_club, larry_marshall, cab_calloway_minnie_the_moocher__lady_with_the_fan_and_jitterbug_sung_by).
starring_as(the_cotton_club, joe_dallesandro, charles_lucky_luciano).
starring_as(the_cotton_club, ed_o_ross, monk).
starring_as(the_cotton_club, frederick_downs_jr, sullen_man).
starring_as(the_cotton_club, diane_venora, gloria_swanson).
starring_as(the_cotton_club, tucker_smallwood, kid_griffin).
starring_as(the_cotton_club, woody_strode, holmes).
starring_as(the_cotton_club, bill_graham, j_w).
starring_as(the_cotton_club, dayton_allen, solly).
starring_as(the_cotton_club, kim_chan, ling).
starring_as(the_cotton_club, ed_rowan, messiah).
starring_as(the_cotton_club, leonard_termo, danny).
starring_as(the_cotton_club, george_cantero, vince_hood).
starring_as(the_cotton_club, brian_tarantina, vince_hood).
starring_as(the_cotton_club, bruce_macvittie, vince_hood).
starring_as(the_cotton_club, james_russo, vince_hood).
starring_as(the_cotton_club, giancarlo_esposito, bumpy_hood).
starring_as(the_cotton_club, bruce_hubbard, bumpy_hood).
starring_as(the_cotton_club, rony_clanton, caspar_holstein).
starring_as(the_cotton_club, damien_leake, bub_jewett).
starring_as(the_cotton_club, bill_cobbs, big_joe_ison).
starring_as(the_cotton_club, joe_lynn, marcial_flores).
starring_as(the_cotton_club, oscar_barnes, spanish_henry).
starring_as(the_cotton_club, ed_zang, hotel_clerk).
starring_as(the_cotton_club, sandra_beall, myrtle_fay).
starring_as(the_cotton_club, zane_mark, duke_ellington).
starring_as(the_cotton_club, tom_signorelli, butch_murdock).
starring_as(the_cotton_club, paul_herman, policeman_1).
starring_as(the_cotton_club, randle_mell, policeman_2).
starring_as(the_cotton_club, steve_vignari, trigger_mike_coppola).
starring_as(the_cotton_club, susan_mechsner, gypsie).
starring_as(the_cotton_club, gregory_rozakis, charlie_chaplin).
starring_as(the_cotton_club, marc_coppola, ted_husing).
starring_as(the_cotton_club, norma_jean_darden, elda_webb).
starring_as(the_cotton_club, robert_earl_jones, stage_door_joe).
starring_as(the_cotton_club, vincent_jerosa, james_cagney).
starring_as(the_cotton_club, rosalind_harris, fanny_brice).
starring_as(the_cotton_club, steve_cafiso, child_in_street).
starring_as(the_cotton_club, john_cafiso, child_in_street).
starring_as(the_cotton_club, sofia_coppola, child_in_street).
starring_as(the_cotton_club, ninon_digiorgio, child_in_street).
starring_as(the_cotton_club, daria_hines, child_in_street).
starring_as(the_cotton_club, patricia_letang, child_in_street).
starring_as(the_cotton_club, christopher_lewis, child_in_street).
starring_as(the_cotton_club, danielle_osborne, child_in_street).
starring_as(the_cotton_club, jason_papalardo, child_in_street).
starring_as(the_cotton_club, demetrius_pena, child_in_street).
starring_as(the_cotton_club, priscilla_baskerville, creole_love_call_sung_by).
starring_as(the_cotton_club, ethel_beatty, bandana_babies_lead_vocal_dancer).
starring_as(the_cotton_club, sydney_goldsmith, barbecue_bess_sung_by).
starring_as(the_cotton_club, james_buster_brown, hoofer).
starring_as(the_cotton_club, ralph_brown, hoofer).
starring_as(the_cotton_club, harold_cromer, hoofer).
starring_as(the_cotton_club, bubba_gaines, hoofer).
starring_as(the_cotton_club, george_hillman, hoofer).
starring_as(the_cotton_club, henry_phace_roberts, hoofer).
starring_as(the_cotton_club, howard_sandman_sims, hoofer).
starring_as(the_cotton_club, jimmy_slyde, hoofer).
starring_as(the_cotton_club, henry_letang, hoofer).
starring_as(the_cotton_club, charles_young, hoofer).
starring_as(the_cotton_club, skip_cunningham, tip_tap__toe).
starring_as(the_cotton_club, luther_fontaine, tip_tap__toe).
starring_as(the_cotton_club, jan_mickens, tip_tap__toe).
starring_as(the_cotton_club, lydia_abarca, dancer).
starring_as(the_cotton_club, sarita_allen, dancer).
starring_as(the_cotton_club, tracey_bass, dancer).
starring_as(the_cotton_club, jacquelyn_bird, dancer).
starring_as(the_cotton_club, shirley_black_brown, dancer).
starring_as(the_cotton_club, jhoe_breedlove, dancer).
starring_as(the_cotton_club, lester_brown, dancer).
starring_as(the_cotton_club, leslie_caldwell, dancer).
starring_as(the_cotton_club, melanie_caldwell, dancer).
starring_as(the_cotton_club, benny_clorey, dancer).
starring_as(the_cotton_club, sheri_cowart, dancer).
starring_as(the_cotton_club, karen_dibianco, dancer).
starring_as(the_cotton_club, cisco_drayton, dancer).
starring_as(the_cotton_club, anne_duquesnay, dancer).
starring_as(the_cotton_club, carla_earle, dancer).
starring_as(the_cotton_club, wendy_edmead, dancer).
starring_as(the_cotton_club, debbie_fitts, dancer).
starring_as(the_cotton_club, ruddy_l_garner, dancer).
starring_as(the_cotton_club, ruthanna_graves, dancer).
starring_as(the_cotton_club, terri_griffin, dancer).
starring_as(the_cotton_club, robin_harmon, dancer).
starring_as(the_cotton_club, jackee_harree, dancer).
starring_as(the_cotton_club, sonya_hensley, dancer).
starring_as(the_cotton_club, dave_jackson, dancer).
starring_as(the_cotton_club, gail_kendricks, dancer).
starring_as(the_cotton_club, christina_kumi_kimball, dancer).
starring_as(the_cotton_club, mary_beth_kurdock, dancer).
starring_as(the_cotton_club, alde_lewis, dancer).
starring_as(the_cotton_club, paula_lynn, dancer).
starring_as(the_cotton_club, bernard_manners, dancer).
starring_as(the_cotton_club, bernard_marsh, dancer).
starring_as(the_cotton_club, david_mcharris, dancer).
starring_as(the_cotton_club, delores_mcharris, dancer).
starring_as(the_cotton_club, vody_najac, dancer).
starring_as(the_cotton_club, vya_negromonte, dancer).
starring_as(the_cotton_club, alice_anne_oates, dancer).
starring_as(the_cotton_club, anne_palmer, dancer).
starring_as(the_cotton_club, julie_pars, dancer).
starring_as(the_cotton_club, antonia_pettiford, dancer).
starring_as(the_cotton_club, valarie_pettiford, dancer).
starring_as(the_cotton_club, janet_powell, dancer).
starring_as(the_cotton_club, renee_rodriguez, dancer).
starring_as(the_cotton_club, tracey_ross, dancer).
starring_as(the_cotton_club, kiki_shepard, dancer).
starring_as(the_cotton_club, gary_thomas, dancer).
starring_as(the_cotton_club, mario_van_peebles, dancer).
starring_as(the_cotton_club, rima_vetter, dancer).
starring_as(the_cotton_club, karen_wadkins, dancer).
starring_as(the_cotton_club, ivery_wheeler, dancer).
starring_as(the_cotton_club, donald_williams, dancer).
starring_as(the_cotton_club, alexis_wilson, dancer).
starring_as(the_cotton_club, george_coutoupis, gangster).
starring_as(the_cotton_club, nicholas_j_giangiulio, screen_test_thug).
starring_as(the_cotton_club, suzanne_kaaren, the_duchess_of_park_avenue).
starring_as(the_cotton_club, mark_margolis, gunman_sooting_cage_s_character).
starring_as(the_cotton_club, kirk_taylor, cotton_club_waiter).
starring_as(the_cotton_club, stan_tracy, legs_diamond_s_bodyguard).
starring_as(the_cotton_club, rick_washburn, hitman).

released(cq, 2001).
directed(cq, roman_coppola).
starring_as(cq, jeremy_davies, paul).
starring_as(cq, angela_lindvall, dragonfly_valentine).
starring_as(cq, lodie_bouchez, marlene).
starring_as(cq, g_rard_depardieu, andrezej).
starring_as(cq, giancarlo_giannini, enzo).
starring_as(cq, massimo_ghini, fabrizio).
starring_as(cq, jason_schwartzman, felix_demarco).
starring_as(cq, billy_zane, mr_e).
starring_as(cq, john_phillip_law, chairman).
starring_as(cq, silvio_muccino, pippo).
starring_as(cq, dean_stockwell, dr_ballard).
starring_as(cq, natalia_vodianova, brigit).
starring_as(cq, bernard_verley, trailer_voiceover_starring_as).
starring_as(cq, l_m_kit_carson, fantasy_critic).
starring_as(cq, chris_bearne, fantasy_critic).
starring_as(cq, jean_paul_scarpitta, fantasy_critic).
starring_as(cq, nicolas_saada, fantasy_critic).
starring_as(cq, remi_fourquin, fantasy_critic).
starring_as(cq, jean_claude_schlim, fantasy_critic).
starring_as(cq, sascha_ley, fantasy_critic).
starring_as(cq, jacques_deglas, fantasy_critic).
starring_as(cq, gilles_soeder, fantasy_critic).
starring_as(cq, julian_nest, festival_critic).
starring_as(cq, greta_seacat, festival_critic).
starring_as(cq, barbara_sarafian, festival_critic).
starring_as(cq, leslie_woodhall, board_member).
starring_as(cq, jean_baptiste_kremer, board_member).
starring_as(cq, franck_sasonoff, angry_man_at_riots).
starring_as(cq, jean_fran_ois_wolff, party_man).
starring_as(cq, eric_connor, long_haired_starring_as_at_party).
starring_as(cq, diana_gartner, cute_model_at_party).
starring_as(cq, st_phanie_gesnel, starring_as_at_party).
starring_as(cq, fr_d_ric_de_brabant, steward).
starring_as(cq, shawn_mortensen, revolutionary_guard).
starring_as(cq, matthieu_tonetti, revolutionary_guard).
starring_as(cq, ann_maes, vampire_starring_as).
starring_as(cq, gintare_parulyte, vampire_starring_as).
starring_as(cq, caroline_lies, vampire_starring_as).
starring_as(cq, stoyanka_tanya_gospodinova, vampire_starring_as).
starring_as(cq, magali_dahan, vampire_starring_as).
starring_as(cq, natalie_broker, vampire_starring_as).
starring_as(cq, wanda_perdelwitz, vampire_starring_as).
starring_as(cq, mark_thompson_ashworth, lead_ghoul).
starring_as(cq, pieter_riemens, assistant_director).
starring_as(cq, federica_citarella, talkative_girl).
starring_as(cq, andrea_cormaci, soldier_boy).
starring_as(cq, corinne_terenzi, teen_lover).
starring_as(cq, sofia_coppola, enzo_s_mistress).
starring_as(cq, emidio_la_vella, italian_starring_as).
starring_as(cq, massimo_schina, friendly_guy_at_party).
starring_as(cq, caroline_colombini, girl_in_miniskirt).
starring_as(cq, rosa_pianeta, woman_in_fiat).
starring_as(cq, christophe_chrompin, jealous_boyfriend).
starring_as(cq, romain_duris, hippie_filmmaker).
starring_as(cq, chris_anthony, second_assistant_director).
starring_as(cq, dean_tavoularis, man_at_screening).

released(crimewave, 1985).
directed(crimewave, sam_raimi).
starring_as(crimewave, louise_lasser, helene_trend).
starring_as(crimewave, paul_l_smith, faron_crush).
starring_as(crimewave, brion_james, arthur_coddish).
starring_as(crimewave, sheree_j_wilson, nancy).
starring_as(crimewave, edward_r_pressman, ernest_trend).
starring_as(crimewave, bruce_campbell, renaldo_the_heel).
starring_as(crimewave, reed_birney, vic_ajax).
starring_as(crimewave, richard_bright, officer_brennan).
starring_as(crimewave, antonio_fargas, blind_man).
starring_as(crimewave, hamid_dana, donald_odegard).
starring_as(crimewave, john_hardy, mr_yarman).
starring_as(crimewave, emil_sitka, colonel_rodgers).
starring_as(crimewave, hal_youngblood, jack_elroy).
starring_as(crimewave, sean_farley, jack_elroy_jr).
starring_as(crimewave, richard_demanincor, officer_garvey).
starring_as(crimewave, carrie_hall, cheap_dish).
starring_as(crimewave, wiley_harker, governor).
starring_as(crimewave, julius_harris, hardened_convict).
starring_as(crimewave, ralph_drischell, executioner).
starring_as(crimewave, robert_symonds, guard_1).
starring_as(crimewave, patrick_stack, guard_2).
starring_as(crimewave, philip_a_gillis, priest).
starring_as(crimewave, bridget_hoffman, nun).
starring_as(crimewave, ann_marie_gillis, nun).
starring_as(crimewave, frances_mcdormand, nun).
starring_as(crimewave, carol_brinn, old_woman).
starring_as(crimewave, matthew_taylor, muscleman).
starring_as(crimewave, perry_mallette, grizzled_veteran).
starring_as(crimewave, chuck_gaidica, weatherman).
starring_as(crimewave, jimmie_launce, announcer).
starring_as(crimewave, joseph_french, bandleader).
starring_as(crimewave, ted_raimi, waiter).
starring_as(crimewave, dennis_chaitlin, fat_waiter).
starring_as(crimewave, joel_coen, reporter_at_execution).
starring_as(crimewave, julie_harris, '').
starring_as(crimewave, dan_nelson, waiter).

released(down_from_the_mountain, 2000).
directed(down_from_the_mountain, nick_doob).
directed(down_from_the_mountain, chris_hegedus).
directed(down_from_the_mountain, d_a_pennebaker).
starring_as(down_from_the_mountain, evelyn_cox, herself).
starring_as(down_from_the_mountain, sidney_cox, himself).
starring_as(down_from_the_mountain, suzanne_cox, herself).
starring_as(down_from_the_mountain, willard_cox, himself).
starring_as(down_from_the_mountain, nathan_best, himself).
starring_as(down_from_the_mountain, issac_freeman, himself).
starring_as(down_from_the_mountain, robert_hamlett, himself).
starring_as(down_from_the_mountain, joseph_rice, himself).
starring_as(down_from_the_mountain, wilson_waters_jr, himself).
starring_as(down_from_the_mountain, john_hartford, himself).
starring_as(down_from_the_mountain, larry_perkins, himself).
starring_as(down_from_the_mountain, emmylou_harris, herself).
starring_as(down_from_the_mountain, chris_thomas_king, himself).
starring_as(down_from_the_mountain, alison_krauss, herself).
starring_as(down_from_the_mountain, colin_linden, himself).
starring_as(down_from_the_mountain, pat_enright, himself).
starring_as(down_from_the_mountain, gene_libbea, himself).
starring_as(down_from_the_mountain, alan_o_bryant, himself).
starring_as(down_from_the_mountain, roland_white, himself).
starring_as(down_from_the_mountain, hannah_peasall, herself).
starring_as(down_from_the_mountain, leah_peasall, herself).
starring_as(down_from_the_mountain, sarah_peasall, herself).
starring_as(down_from_the_mountain, ralph_stanley, himself).
starring_as(down_from_the_mountain, gillian_welch, herself).
starring_as(down_from_the_mountain, david_rawlings, himself).
starring_as(down_from_the_mountain, buck_white, himself).
starring_as(down_from_the_mountain, cheryl_white, herself).
starring_as(down_from_the_mountain, sharon_white, herself).
starring_as(down_from_the_mountain, barry_bales, house_band_bass).
starring_as(down_from_the_mountain, ron_block, house_band_banjo).
starring_as(down_from_the_mountain, mike_compton, house_band_mandolin).
starring_as(down_from_the_mountain, jerry_douglas, house_band_dobro).
starring_as(down_from_the_mountain, stuart_duncan, house_band_fiddle).
starring_as(down_from_the_mountain, chris_sharp, house_band_guitar).
starring_as(down_from_the_mountain, dan_tyminski, house_band_guitar).
starring_as(down_from_the_mountain, t_bone_burnett, himself).
starring_as(down_from_the_mountain, ethan_coen, himself).
starring_as(down_from_the_mountain, joel_coen, himself).
starring_as(down_from_the_mountain, holly_hunter, herself).
starring_as(down_from_the_mountain, tim_blake_nelson, himself).
starring_as(down_from_the_mountain, billy_bob_thornton, audience_member).
starring_as(down_from_the_mountain, wes_motley, audience_member).
starring_as(down_from_the_mountain, tamara_trexler, audience_member).

released(fargo, 1996).
directed(fargo, ethan_coen).
directed(fargo, joel_coen).
starring_as(fargo, william_h_macy, jerry_lundegaard).
starring_as(fargo, steve_buscemi, carl_showalter).
starring_as(fargo, peter_stormare, gaear_grimsrud).
starring_as(fargo, kristin_rudr_d, jean_lundegaard).
starring_as(fargo, harve_presnell, wade_gustafson).
starring_as(fargo, tony_denman, scotty_lundegaard).
starring_as(fargo, gary_houston, irate_customer).
starring_as(fargo, sally_wingert, irate_customer_s_wife).
starring_as(fargo, kurt_schweickhardt, car_salesman).
starring_as(fargo, larissa_kokernot, hooker_1).
starring_as(fargo, melissa_peterman, hooker_2).
starring_as(fargo, steve_reevis, shep_proudfoot).
starring_as(fargo, warren_keith, reilly_diefenbach).
starring_as(fargo, steve_edelman, morning_show_host).
starring_as(fargo, sharon_anderson, morning_show_hostess).
starring_as(fargo, larry_brandenburg, stan_grossman).
starring_as(fargo, james_gaulke, state_trooper).
starring_as(fargo, j_todd_anderson, victim_in_the_field).
starring_as(fargo, michelle_suzanne_ledoux, victim_in_car).
starring_as(fargo, frances_mcdormand, marge_gunderson).
starring_as(fargo, john_carroll_lynch, norm_gunderson).
starring_as(fargo, bruce_bohne, lou).
starring_as(fargo, petra_boden, cashier).
starring_as(fargo, steve_park, mike_yanagita).
starring_as(fargo, wayne_a_evenson, customer).
starring_as(fargo, cliff_rakerd, officer_olson).
starring_as(fargo, jessica_shepherd, hotel_clerk).
starring_as(fargo, peter_schmitz, airport_lot_attendant).
starring_as(fargo, steven_i_schafer, mechanic).
starring_as(fargo, michelle_hutchison, escort).
starring_as(fargo, david_s_lomax, man_in_hallway).
starring_as(fargo, jos_feliciano, himself).
starring_as(fargo, bix_skahill, night_parking_attendant).
starring_as(fargo, bain_boehlke, mr_mohra).
starring_as(fargo, rose_stockton, valerie).
starring_as(fargo, robert_ozasky, bismarck_cop_1).
starring_as(fargo, john_bandemer, bismarck_cop_2).
starring_as(fargo, don_wescott, bark_beetle_narrator).
starring_as(fargo, bruce_campbell, soap_opera_starring_as).
starring_as(fargo, clifford_nelson, heavyset_man_in_bar).

released(the_firm, 1993).
directed(the_firm, sydney_pollack).
starring_as(the_firm, tom_cruise, mitch_mcdeere).
starring_as(the_firm, jeanne_tripplehorn, abby_mcdeere).
starring_as(the_firm, gene_hackman, avery_tolar).
starring_as(the_firm, hal_holbrook, oliver_lambert).
starring_as(the_firm, terry_kinney, lamar_quinn).
starring_as(the_firm, wilford_brimley, william_devasher).
starring_as(the_firm, ed_harris, wayne_tarrance).
starring_as(the_firm, holly_hunter, tammy_hemphill).
starring_as(the_firm, david_strathairn, ray_mcdeere).
starring_as(the_firm, gary_busey, eddie_lomax).
starring_as(the_firm, steven_hill, f_denton_voyles).
starring_as(the_firm, tobin_bell, the_nordic_man).
starring_as(the_firm, barbara_garrick, kay_quinn).
starring_as(the_firm, jerry_hardin, royce_mcknight).
starring_as(the_firm, paul_calderon, thomas_richie).
starring_as(the_firm, jerry_weintraub, sonny_capps).
starring_as(the_firm, sullivan_walker, barry_abanks).
starring_as(the_firm, karina_lombard, young_woman_on_beach).
starring_as(the_firm, margo_martindale, nina_huff).
starring_as(the_firm, john_beal, nathan_locke).
starring_as(the_firm, dean_norris, the_squat_man).
starring_as(the_firm, lou_walker, frank_mulholland).
starring_as(the_firm, debbie_turner, rental_agent).
starring_as(the_firm, tommy_cresswell, wally_hudson).
starring_as(the_firm, david_a_kimball, randall_dunbar).
starring_as(the_firm, don_jones, attorney).
starring_as(the_firm, michael_allen, attorney).
starring_as(the_firm, levi_frazier_jr, restaurant_waiter).
starring_as(the_firm, brian_casey, telephone_installer).
starring_as(the_firm, reverend_william_j_parham, minister).
starring_as(the_firm, victor_nelson, cafe_waiter).
starring_as(the_firm, richard_ranta, congressman_billings).
starring_as(the_firm, janie_paris, madge).
starring_as(the_firm, frank_crawford, judge).
starring_as(the_firm, bart_whiteman, dutch).
starring_as(the_firm, david_dwyer, prison_guard).
starring_as(the_firm, mark_w_johnson, fbi_agent).
starring_as(the_firm, jerry_chipman, fbi_agent).
starring_as(the_firm, jimmy_lackie, technician).
starring_as(the_firm, afemo_omilami, cotton_truck_driver).
starring_as(the_firm, clint_smith, cotton_truck_driver).
starring_as(the_firm, susan_elliott, river_museum_guide).
starring_as(the_firm, erin_branham, river_museum_guide).
starring_as(the_firm, ed_connelly, pilot).
starring_as(the_firm, joey_anderson, ruth).
starring_as(the_firm, deborah_thomas, quinns_maid).
starring_as(the_firm, tommy_matthews, elvis_aaron_hemphill).
starring_as(the_firm, chris_schadrack, lawyer_recruiter).
starring_as(the_firm, buck_ford, lawyer_recruiter).
starring_as(the_firm, jonathan_kaplan, lawyer_recruiter).
starring_as(the_firm, rebecca_glenn, young_woman_at_patio_bar).
starring_as(the_firm, terri_welles, woman_dancing_with_avery).
starring_as(the_firm, greg_goossen, vietnam_veteran).
starring_as(the_firm, jeane_aufdenberg, car_rental_agent).
starring_as(the_firm, william_r_booth, seaplane_pilot).
starring_as(the_firm, ollie_nightingale, restaurant_singer).
starring_as(the_firm, teenie_hodges, restaurant_lead_guitarist).
starring_as(the_firm, little_jimmy_king, memphis_street_musician).
starring_as(the_firm, james_white, singer_at_hyatt).
starring_as(the_firm, shan_brisendine, furniture_mover).
starring_as(the_firm, harry_dach, garbage_truck_driver).
starring_as(the_firm, julia_hayes, girl_in_bar).
starring_as(the_firm, tom_mccrory, associate).
starring_as(the_firm, paul_sorvino, tommie_morolto).
starring_as(the_firm, joe_viterelli, joey_morolto).

released(frankenweenie, 1984).
directed(frankenweenie, tim_burton).
starring_as(frankenweenie, shelley_duvall, susan_frankenstein).
starring_as(frankenweenie, daniel_stern, ben_frankenstein).
starring_as(frankenweenie, barret_oliver, victor_frankenstein).
starring_as(frankenweenie, joseph_maher, mr_chambers).
starring_as(frankenweenie, roz_braverman, mrs_epstein).
starring_as(frankenweenie, paul_bartel, mr_walsh).
starring_as(frankenweenie, sofia_coppola, anne_chambers).
starring_as(frankenweenie, jason_hervey, frank_dale).
starring_as(frankenweenie, paul_c_scott, mike_anderson).
starring_as(frankenweenie, helen_boll, mrs_curtis).
starring_as(frankenweenie, sparky, sparky).
starring_as(frankenweenie, rusty_james, raymond).

released(ghost_busters, 1984).
directed(ghost_busters, ivan_reitman).
starring_as(ghost_busters, bill_murray, dr_peter_venkman).
starring_as(ghost_busters, dan_aykroyd, dr_raymond_stantz).
starring_as(ghost_busters, sigourney_weaver, dana_barrett).
starring_as(ghost_busters, harold_ramis, dr_egon_spengler).
starring_as(ghost_busters, rick_moranis, louis_tully).
starring_as(ghost_busters, annie_potts, janine_melnitz).
starring_as(ghost_busters, william_atherton, walter_peck_wally_wick).
starring_as(ghost_busters, ernie_hudson, winston_zeddmore).
starring_as(ghost_busters, david_margulies, mayor).
starring_as(ghost_busters, steven_tash, male_student).
starring_as(ghost_busters, jennifer_runyon, female_student).
starring_as(ghost_busters, slavitza_jovan, gozer).
starring_as(ghost_busters, michael_ensign, hotel_manager).
starring_as(ghost_busters, alice_drummond, librarian).
starring_as(ghost_busters, jordan_charney, dean_yeager).
starring_as(ghost_busters, timothy_carhart, violinist).
starring_as(ghost_busters, john_rothman, library_administrator).
starring_as(ghost_busters, tom_mcdermott, archbishop).
starring_as(ghost_busters, roger_grimsby, himself).
starring_as(ghost_busters, larry_king, himself).
starring_as(ghost_busters, joe_franklin, himself).
starring_as(ghost_busters, casey_kasem, himself).
starring_as(ghost_busters, john_ring, fire_commissioner).
starring_as(ghost_busters, norman_matlock, police_commissioner).
starring_as(ghost_busters, joe_cirillo, police_captain).
starring_as(ghost_busters, joe_schmieg, police_seargeant).
starring_as(ghost_busters, reginald_veljohnson, jail_guard).
starring_as(ghost_busters, rhoda_gemignani, real_estate_woman).
starring_as(ghost_busters, murray_rubin, man_at_elevator).
starring_as(ghost_busters, larry_dilg, con_edison_man).
starring_as(ghost_busters, danny_stone, coachman).
starring_as(ghost_busters, patty_dworkin, woman_at_party).
starring_as(ghost_busters, jean_kasem, tall_woman_at_party).
starring_as(ghost_busters, lenny_del_genio, doorman).
starring_as(ghost_busters, frances_e_nealy, chambermaid).
starring_as(ghost_busters, sam_moses, hot_dog_vendor).
starring_as(ghost_busters, christopher_wynkoop, tv_reporter).
starring_as(ghost_busters, winston_may, businessman_in_cab).
starring_as(ghost_busters, tommy_hollis, mayor_s_aide).
starring_as(ghost_busters, eda_reiss_merin, louis_s_neighbor).
starring_as(ghost_busters, ric_mancini, policeman_at_apartment).
starring_as(ghost_busters, kathryn_janssen, mrs_van_hoffman).
starring_as(ghost_busters, stanley_grover, reporter).
starring_as(ghost_busters, carol_ann_henry, reporter).
starring_as(ghost_busters, james_hardie, reporter).
starring_as(ghost_busters, frances_turner, reporter).
starring_as(ghost_busters, nancy_kelly, reporter).
starring_as(ghost_busters, paul_trafas, ted_fleming).
starring_as(ghost_busters, cheryl_birchenfield, annette_fleming).
starring_as(ghost_busters, ruth_oliver, library_ghost).
starring_as(ghost_busters, kymberly_herrin, dream_ghost).
starring_as(ghost_busters, larry_bilzarian, prisoner).
starring_as(ghost_busters, matteo_cafiso, boy_at_hot_dog_stand).
starring_as(ghost_busters, paddi_edwards, gozer).
starring_as(ghost_busters, deborah_gibson, birthday_girl_in_tavern_on_the_green).
starring_as(ghost_busters, charles_levin, honeymooner).
starring_as(ghost_busters, joseph_marzano, man_in_taxi).
starring_as(ghost_busters, joe_medjuck, man_at_library).
starring_as(ghost_busters, frank_patton, city_hall_cop).
starring_as(ghost_busters, harrison_ray, terror_dog).
starring_as(ghost_busters, ivan_reitman, zuul_slimer).
starring_as(ghost_busters, mario_todisco, prisoner).
starring_as(ghost_busters, bill_walton, himself).

released(girl_with_a_pearl_earring, 2003).
directed(girl_with_a_pearl_earring, peter_webber).
starring_as(girl_with_a_pearl_earring, colin_firth, johannes_vermeer).
starring_as(girl_with_a_pearl_earring, scarlett_johansson, griet).
starring_as(girl_with_a_pearl_earring, tom_wilkinson, van_ruijven).
starring_as(girl_with_a_pearl_earring, judy_parfitt, maria_thins).
starring_as(girl_with_a_pearl_earring, cillian_murphy, pieter).
starring_as(girl_with_a_pearl_earring, essie_davis, catharina_vermeer).
starring_as(girl_with_a_pearl_earring, joanna_scanlan, tanneke).
starring_as(girl_with_a_pearl_earring, alakina_mann, cornelia_vermeer).
starring_as(girl_with_a_pearl_earring, chris_mchallem, griet_s_father).
starring_as(girl_with_a_pearl_earring, gabrielle_reidy, griet_s_mother).
starring_as(girl_with_a_pearl_earring, rollo_weeks, frans).
starring_as(girl_with_a_pearl_earring, anna_popplewell, maertge).
starring_as(girl_with_a_pearl_earring, ana_s_nepper, lisbeth).
starring_as(girl_with_a_pearl_earring, melanie_meyfroid, aleydis).
starring_as(girl_with_a_pearl_earring, nathan_nepper, johannes).
starring_as(girl_with_a_pearl_earring, lola_carpenter, baby_franciscus).
starring_as(girl_with_a_pearl_earring, charlotte_carpenter, baby_franciscus).
starring_as(girl_with_a_pearl_earring, olivia_chauveau, baby_franciscus).
starring_as(girl_with_a_pearl_earring, geoff_bell, paul_the_butcher).
starring_as(girl_with_a_pearl_earring, virginie_colin, emilie_van_ruijven).
starring_as(girl_with_a_pearl_earring, sarah_drews, van_ruijven_s_daughter).
starring_as(girl_with_a_pearl_earring, christelle_bulckaen, wet_nurse).
starring_as(girl_with_a_pearl_earring, john_mcenery, apothecary).
starring_as(girl_with_a_pearl_earring, gintare_parulyte, model).
starring_as(girl_with_a_pearl_earring, claire_johnston, white_haired_woman).
starring_as(girl_with_a_pearl_earring, marc_maes, old_gentleman).
starring_as(girl_with_a_pearl_earring, robert_sibenaler, priest).
starring_as(girl_with_a_pearl_earring, dustin_james, servant_1).
starring_as(girl_with_a_pearl_earring, joe_reavis, servant_2).
starring_as(girl_with_a_pearl_earring, martin_serene, sergeant).
starring_as(girl_with_a_pearl_earring, chris_kelly, gay_blade).
starring_as(girl_with_a_pearl_earring, leslie_woodhall, neighbour).

released(the_godfather, 1972).
directed(the_godfather, francis_ford_coppola).
starring_as(the_godfather, marlon_brando, don_vito_corleone).
starring_as(the_godfather, al_pacino, michael_corleone).
starring_as(the_godfather, james_caan, santino_sonny_corleone).
starring_as(the_godfather, richard_s_castellano, pete_clemenza).
starring_as(the_godfather, robert_duvall, tom_hagen).
starring_as(the_godfather, sterling_hayden, capt_mark_mccluskey).
starring_as(the_godfather, john_marley, jack_woltz).
starring_as(the_godfather, richard_conte, emilio_barzini).
starring_as(the_godfather, al_lettieri, virgil_sollozzo).
starring_as(the_godfather, diane_keaton, kay_adams).
starring_as(the_godfather, abe_vigoda, salvadore_sally_tessio).
starring_as(the_godfather, talia_shire, connie).
starring_as(the_godfather, gianni_russo, carlo_rizzi).
starring_as(the_godfather, john_cazale, fredo).
starring_as(the_godfather, rudy_bond, ottilio_cuneo).
starring_as(the_godfather, al_martino, johnny_fontane).
starring_as(the_godfather, morgana_king, mama_corleone).
starring_as(the_godfather, lenny_montana, luca_brasi).
starring_as(the_godfather, john_martino, paulie_gatto).
starring_as(the_godfather, salvatore_corsitto, amerigo_bonasera).
starring_as(the_godfather, richard_bright, al_neri).
starring_as(the_godfather, alex_rocco, moe_greene).
starring_as(the_godfather, tony_giorgio, bruno_tattaglia).
starring_as(the_godfather, vito_scotti, nazorine).
starring_as(the_godfather, tere_livrano, theresa_hagen).
starring_as(the_godfather, victor_rendina, philip_tattaglia).
starring_as(the_godfather, jeannie_linero, lucy_mancini).
starring_as(the_godfather, julie_gregg, sandra_corleone).
starring_as(the_godfather, ardell_sheridan, mrs_clemenza).
starring_as(the_godfather, simonetta_stefanelli, apollonia_vitelli_corleone).
starring_as(the_godfather, angelo_infanti, fabrizio).
starring_as(the_godfather, corrado_gaipa, don_tommasino).
starring_as(the_godfather, franco_citti, calo).
starring_as(the_godfather, saro_urz, vitelli).
starring_as(the_godfather, carmine_coppola, piano_player_in_montage_scene).
starring_as(the_godfather, gian_carlo_coppola, baptism_observer).
starring_as(the_godfather, sofia_coppola, michael_francis_rizzi).
starring_as(the_godfather, ron_gilbert, usher_in_bridal_party).
starring_as(the_godfather, anthony_gounaris, anthony_vito_corleone).
starring_as(the_godfather, joe_lo_grippo, sonny_s_bodyguard).
starring_as(the_godfather, sonny_grosso, cop_with_capt_mccluskey_outside_hospital).
starring_as(the_godfather, louis_guss, don_zaluchi_outspoken_don_at_the_peace_conference).
starring_as(the_godfather, randy_jurgensen, sonny_s_killer_1).
starring_as(the_godfather, tony_lip, wedding_guest).
starring_as(the_godfather, frank_macetta, '').
starring_as(the_godfather, lou_martini_jr, boy_at_wedding).
starring_as(the_godfather, father_joseph_medeglia, priest_at_baptism).
starring_as(the_godfather, rick_petrucelli, man_in_passenger_seat_when_michael_is_driven_to_the_hospital).
starring_as(the_godfather, burt_richards, floral_designer).
starring_as(the_godfather, sal_richards, drunk).
starring_as(the_godfather, tom_rosqui, rocco_lampone).
starring_as(the_godfather, frank_sivero, extra).
starring_as(the_godfather, filomena_spagnuolo, extra_at_wedding_scene).
starring_as(the_godfather, joe_spinell, willie_cicci).
starring_as(the_godfather, gabriele_torrei, enzo_robutti_the_baker).
starring_as(the_godfather, nick_vallelonga, wedding_party_guest).
starring_as(the_godfather, ed_vantura, wedding_guest).
starring_as(the_godfather, matthew_vlahakis, clemenza_s_son_pushing_toy_car_in_driveway).

released(the_godfather_part_ii, 1974).
directed(the_godfather_part_ii, francis_ford_coppola).
starring_as(the_godfather_part_ii, al_pacino, don_michael_corleone).
starring_as(the_godfather_part_ii, robert_duvall, tom_hagen).
starring_as(the_godfather_part_ii, diane_keaton, kay_corleone).
starring_as(the_godfather_part_ii, robert_de_niro, vito_corleone).
starring_as(the_godfather_part_ii, john_cazale, fredo_corleone).
starring_as(the_godfather_part_ii, talia_shire, connie_corleone).
starring_as(the_godfather_part_ii, lee_strasberg, hyman_roth).
starring_as(the_godfather_part_ii, michael_v_gazzo, frankie_pentangeli).
starring_as(the_godfather_part_ii, g_d_spradlin, sen_pat_geary).
starring_as(the_godfather_part_ii, richard_bright, al_neri).
starring_as(the_godfather_part_ii, gastone_moschin, don_fanucci).
starring_as(the_godfather_part_ii, tom_rosqui, rocco_lampone).
starring_as(the_godfather_part_ii, bruno_kirby, young_clemenza_peter).
starring_as(the_godfather_part_ii, frank_sivero, genco_abbandando).
starring_as(the_godfather_part_ii, francesca_de_sapio, young_mama_corleone).
starring_as(the_godfather_part_ii, morgana_king, older_carmella_mama_corleone).
starring_as(the_godfather_part_ii, marianna_hill, deanna_dunn_corleone).
starring_as(the_godfather_part_ii, leopoldo_trieste, signor_roberto_landlord).
starring_as(the_godfather_part_ii, dominic_chianese, johnny_ola).
starring_as(the_godfather_part_ii, amerigo_tot, busetta_michael_s_bodyguard).
starring_as(the_godfather_part_ii, troy_donahue, merle_johnson).
starring_as(the_godfather_part_ii, john_aprea, young_sal_tessio).
starring_as(the_godfather_part_ii, joe_spinell, willie_cicci).
starring_as(the_godfather_part_ii, james_caan, sonny_corleone_special_participation).
starring_as(the_godfather_part_ii, abe_vigoda, sal_tessio).
starring_as(the_godfather_part_ii, tere_livrano, theresa_hagen).
starring_as(the_godfather_part_ii, gianni_russo, carlo_rizzi).
starring_as(the_godfather_part_ii, maria_carta, signora_andolini_vito_s_mother).
starring_as(the_godfather_part_ii, oreste_baldini, young_vito_andolini).
starring_as(the_godfather_part_ii, giuseppe_sillato, don_francesco_ciccio).
starring_as(the_godfather_part_ii, mario_cotone, don_tommasino).
starring_as(the_godfather_part_ii, james_gounaris, anthony_vito_corleone).
starring_as(the_godfather_part_ii, fay_spain, mrs_marcia_roth).
starring_as(the_godfather_part_ii, harry_dean_stanton, fbi_man_1).
starring_as(the_godfather_part_ii, david_baker, fbi_man_2).
starring_as(the_godfather_part_ii, carmine_caridi, carmine_rosato).
starring_as(the_godfather_part_ii, danny_aiello, tony_rosato).
starring_as(the_godfather_part_ii, carmine_foresta, policeman).
starring_as(the_godfather_part_ii, nick_discenza, bartender).
starring_as(the_godfather_part_ii, father_joseph_medeglia, father_carmelo).
starring_as(the_godfather_part_ii, william_bowers, senate_committee_chairman).
starring_as(the_godfather_part_ii, joseph_della_sorte, michael_s_buttonman_1).
starring_as(the_godfather_part_ii, carmen_argenziano, michael_s_buttonman_2).
starring_as(the_godfather_part_ii, joe_lo_grippo, michael_s_buttonman_3).
starring_as(the_godfather_part_ii, ezio_flagello, impresario).
starring_as(the_godfather_part_ii, livio_giorgi, tenor_in_senza_mamma).
starring_as(the_godfather_part_ii, kathleen_beller, girl_in_senza_mamma).
starring_as(the_godfather_part_ii, saveria_mazzola, signora_colombo).
starring_as(the_godfather_part_ii, tito_alba, cuban_pres_fulgencio_batista).
starring_as(the_godfather_part_ii, johnny_naranjo, cuban_translator).
starring_as(the_godfather_part_ii, elda_maida, pentangeli_s_wife).
starring_as(the_godfather_part_ii, salvatore_po, vincenzo_pentangeli).
starring_as(the_godfather_part_ii, ignazio_pappalardo, mosca_assassin_in_sicily).
starring_as(the_godfather_part_ii, andrea_maugeri, strollo).
starring_as(the_godfather_part_ii, peter_lacorte, signor_abbandando).
starring_as(the_godfather_part_ii, vincent_coppola, street_vendor).
starring_as(the_godfather_part_ii, peter_donat, questadt).
starring_as(the_godfather_part_ii, tom_dahlgren, fred_corngold).
starring_as(the_godfather_part_ii, paul_b_brown, sen_ream).
starring_as(the_godfather_part_ii, phil_feldman, senator_1).
starring_as(the_godfather_part_ii, roger_corman, senator_2).
starring_as(the_godfather_part_ii, ivonne_coll, yolanda).
starring_as(the_godfather_part_ii, joe_de_nicola, attendant_at_brothel).
starring_as(the_godfather_part_ii, edward_van_sickle, ellis_island_doctor).
starring_as(the_godfather_part_ii, gabriella_belloni, ellis_island_nurse).
starring_as(the_godfather_part_ii, richard_watson, customs_official).
starring_as(the_godfather_part_ii, venancia_grangerard, cuban_nurse).
starring_as(the_godfather_part_ii, erica_yohn, governess).
starring_as(the_godfather_part_ii, theresa_tirelli, midwife).
starring_as(the_godfather_part_ii, roman_coppola, sonny_corleone_as_a_boy).
starring_as(the_godfather_part_ii, sofia_coppola, child_on_steamship_in_ny_harbor).
starring_as(the_godfather_part_ii, larry_guardino, vito_s_uncle).
starring_as(the_godfather_part_ii, gary_kurtz, photographer_in_court).
starring_as(the_godfather_part_ii, laura_lyons, '').
starring_as(the_godfather_part_ii, connie_mason, extra).
starring_as(the_godfather_part_ii, john_megna, young_hyman_roth).
starring_as(the_godfather_part_ii, frank_pesce, extra).
starring_as(the_godfather_part_ii, filomena_spagnuolo, extra_in_little_italy).

released(the_godfather_part_iii, 1990).
directed(the_godfather_part_iii, francis_ford_coppola).
starring_as(the_godfather_part_iii, al_pacino, don_michael_corleone).
starring_as(the_godfather_part_iii, diane_keaton, kay_adams_mitchelson).
starring_as(the_godfather_part_iii, talia_shire, connie_corleone_rizzi).
starring_as(the_godfather_part_iii, andy_garcia, don_vincent_vinnie_mancini_corleone).
starring_as(the_godfather_part_iii, eli_wallach, don_altobello).
starring_as(the_godfather_part_iii, joe_mantegna, joey_zasa).
starring_as(the_godfather_part_iii, george_hamilton, b_j_harrison).
starring_as(the_godfather_part_iii, bridget_fonda, grace_hamilton).
starring_as(the_godfather_part_iii, sofia_coppola, mary_corleone).
starring_as(the_godfather_part_iii, raf_vallone, cardinal_lamberto).
starring_as(the_godfather_part_iii, franc_d_ambrosio, anthony_vito_corleone_turiddu_sequence_cavalleria_rusticana).
starring_as(the_godfather_part_iii, donal_donnelly, archbishop_gilday).
starring_as(the_godfather_part_iii, richard_bright, al_neri).
starring_as(the_godfather_part_iii, helmut_berger, frederick_keinszig).
starring_as(the_godfather_part_iii, don_novello, dominic_abbandando).
starring_as(the_godfather_part_iii, john_savage, father_andrew_hagen).
starring_as(the_godfather_part_iii, franco_citti, calo).
starring_as(the_godfather_part_iii, mario_donatone, mosca).
starring_as(the_godfather_part_iii, vittorio_duse, don_tommasino).
starring_as(the_godfather_part_iii, enzo_robutti, don_licio_lucchesi).
starring_as(the_godfather_part_iii, michele_russo, spara).
starring_as(the_godfather_part_iii, al_martino, johnny_fontane).
starring_as(the_godfather_part_iii, robert_cicchini, lou_penning).
starring_as(the_godfather_part_iii, rogerio_miranda, twin_bodyguard_armand).
starring_as(the_godfather_part_iii, carlos_miranda, twin_bodyguard_francesco).
starring_as(the_godfather_part_iii, vito_antuofermo, anthony_the_ant_squigliaro_joey_zaza_s_bulldog).
starring_as(the_godfather_part_iii, robert_vento, father_john).
starring_as(the_godfather_part_iii, willie_brown, party_politician).
starring_as(the_godfather_part_iii, jeannie_linero, lucy_mancini).
starring_as(the_godfather_part_iii, remo_remotti, camerlengo_cardinal_cardinal__sistine).
starring_as(the_godfather_part_iii, jeanne_savarino_pesch, francesca_corleone).
starring_as(the_godfather_part_iii, janet_savarino_smith, kathryn_corleone).
starring_as(the_godfather_part_iii, tere_livrano, teresa_hagen).
starring_as(the_godfather_part_iii, carmine_caridi, albert_volpe).
starring_as(the_godfather_part_iii, don_costello, frank_romano).
starring_as(the_godfather_part_iii, al_ruscio, leo_cuneo).
starring_as(the_godfather_part_iii, mickey_knox, marty_parisi).
starring_as(the_godfather_part_iii, rick_aviles, mask_1).
starring_as(the_godfather_part_iii, michael_bowen, mask_2).
starring_as(the_godfather_part_iii, brett_halsey, douglas_michelson).
starring_as(the_godfather_part_iii, gabriele_torrei, enzo_the_baker).
starring_as(the_godfather_part_iii, john_abineri, hamilton_banker).
starring_as(the_godfather_part_iii, brian_freilino, stockholder).
starring_as(the_godfather_part_iii, gregory_corso, unruly_stockholder).
starring_as(the_godfather_part_iii, marino_mas, lupo).
starring_as(the_godfather_part_iii, dado_ruspoli, vanni).
starring_as(the_godfather_part_iii, valeria_sabel, sister_vincenza).
starring_as(the_godfather_part_iii, luigi_laezza, keinszig_killer).
starring_as(the_godfather_part_iii, beppe_pianviti, keinszig_killer).
starring_as(the_godfather_part_iii, santo_indelicato, guardia_del_corpo).
starring_as(the_godfather_part_iii, francesco_paolo_bellante, autista_di_don_tommasino).
starring_as(the_godfather_part_iii, paco_reconti, gesu).
starring_as(the_godfather_part_iii, mimmo_cuticchio, puppet_narrator).
starring_as(the_godfather_part_iii, richard_honigman, party_reporter).
starring_as(the_godfather_part_iii, nicky_blair, nicky_the_casino_host).
starring_as(the_godfather_part_iii, anthony_guidera, anthony_the_bodyguard).
starring_as(the_godfather_part_iii, frank_tarsia, frankie_the_bodyguard).
starring_as(the_godfather_part_iii, diane_agostini, woman_with_child_at_street_fair).
starring_as(the_godfather_part_iii, jessica_di_cicco, child).
starring_as(the_godfather_part_iii, catherine_scorsese, woman_in_cafe).
starring_as(the_godfather_part_iii, ida_bernardini, woman_in_cafe).
starring_as(the_godfather_part_iii, joe_drago, party_security).
starring_as(the_godfather_part_iii, david_hume_kennerly, party_photographer).
starring_as(the_godfather_part_iii, james_d_damiano, son_playing_soccer).
starring_as(the_godfather_part_iii, michael_boccio, father_of_soccer_player).
starring_as(the_godfather_part_iii, anton_coppola, conductor_sequence_cavalleria_rusticana).
starring_as(the_godfather_part_iii, elena_lo_forte, santuzza_played_by_sequence_cavalleria_rusticana).
starring_as(the_godfather_part_iii, madelyn_ren_e_monti, santuzza_sung_by_lola_sequence_cavalleria_rusticana).
starring_as(the_godfather_part_iii, corinna_vozza, lucia_sequence_cavalleria_rusticana).
starring_as(the_godfather_part_iii, angelo_romero, alfio_played_by_sequence_cavalleria_rusticana).
starring_as(the_godfather_part_iii, paolo_gavanelli, alfio_sung_by_sequence_cavalleria_rusticana).
starring_as(the_godfather_part_iii, salvatore_billa, hired_assassin).
starring_as(the_godfather_part_iii, sal_borgese, lucchesi_s_door_guard).
starring_as(the_godfather_part_iii, james_caan, sonny_corleone).
starring_as(the_godfather_part_iii, richard_s_castellano, peter_clemenza).
starring_as(the_godfather_part_iii, john_cazale, fredo_corleone).
starring_as(the_godfather_part_iii, tony_devon, mob_family_lawyer_at_the_church).
starring_as(the_godfather_part_iii, andrea_girolami, extra).
starring_as(the_godfather_part_iii, simonetta_stefanelli, apollonia_vitelli_corleone).
starring_as(the_godfather_part_iii, lee_strasberg, hyman_roth_stukowski).
starring_as(the_godfather_part_iii, f_x_vitolo, pasquale).

released(groundhog_day, 1993).
directed(groundhog_day, harold_ramis).
starring_as(groundhog_day, bill_murray, phil_connors).
starring_as(groundhog_day, andie_macdowell, rita).
starring_as(groundhog_day, chris_elliott, larry).
starring_as(groundhog_day, stephen_tobolowsky, ned_ryerson).
starring_as(groundhog_day, brian_doyle_murray, buster_green).
starring_as(groundhog_day, marita_geraghty, nancy_taylor).
starring_as(groundhog_day, angela_paton, mrs_lancaster).
starring_as(groundhog_day, rick_ducommun, gus).
starring_as(groundhog_day, rick_overton, ralph).
starring_as(groundhog_day, robin_duke, doris_the_waitress).
starring_as(groundhog_day, carol_bivins, anchorwoman).
starring_as(groundhog_day, willie_garson, kenny).
starring_as(groundhog_day, ken_hudson_campbell, man_in_hallway).
starring_as(groundhog_day, les_podewell, old_man).
starring_as(groundhog_day, rod_sell, groundhog_official).
starring_as(groundhog_day, tom_milanovich, state_trooper).
starring_as(groundhog_day, john_m_watson_sr, bartender).
starring_as(groundhog_day, peggy_roeder, piano_teacher).
starring_as(groundhog_day, harold_ramis, neurologist).
starring_as(groundhog_day, david_pasquesi, psychiatrist).
starring_as(groundhog_day, lee_r_sellars, cop).
starring_as(groundhog_day, chet_dubowski, felix_bank_guard).
starring_as(groundhog_day, doc_erickson, herman_bank_guard).
starring_as(groundhog_day, sandy_maschmeyer, phil_s_released_date).
starring_as(groundhog_day, leighanne_o_neil, fan_on_street).
starring_as(groundhog_day, evangeline_binkley, jeopardy__viewer).
starring_as(groundhog_day, samuel_mages, jeopardy__viewer).
starring_as(groundhog_day, ben_zwick, jeopardy__viewer).
starring_as(groundhog_day, hynden_walch, debbie_kleiser).
starring_as(groundhog_day, michael_shannon, fred_kleiser).
starring_as(groundhog_day, timothy_hendrickson, bill_waiter).
starring_as(groundhog_day, martha_webster, alice_waitress).
starring_as(groundhog_day, angela_gollan, piano_student).
starring_as(groundhog_day, shaun_chaiyabhat, boy_in_tree).
starring_as(groundhog_day, dianne_b_shaw, e_r_nurse).
starring_as(groundhog_day, barbara_ann_grimes, flat_tire_lady).
starring_as(groundhog_day, ann_heekin, flat_tire_lady).
starring_as(groundhog_day, lucina_paquet, flat_tire_lady).
starring_as(groundhog_day, brenda_pickleman, buster_s_wife).
starring_as(groundhog_day, amy_murdoch, buster_s_daughter).
starring_as(groundhog_day, eric_saiet, buster_s_son).
starring_as(groundhog_day, lindsay_albert, woman_with_cigarette).
starring_as(groundhog_day, roger_adler, guitarist).
starring_as(groundhog_day, ben_a_fish, bassist).
starring_as(groundhog_day, don_riozz_mcnichols, drummer).
starring_as(groundhog_day, brian_willig, saxophonist).
starring_as(groundhog_day, richard_henzel, dj).
starring_as(groundhog_day, rob_riley, dj).
starring_as(groundhog_day, scooter, the_groundhog).
starring_as(groundhog_day, douglas_blakeslee, man_with_snow_shovel).
starring_as(groundhog_day, leslie_frates, herself__jeopardy__contestant).
starring_as(groundhog_day, mason_gamble, '').
starring_as(groundhog_day, simon_harvey, news_reporter).
starring_as(groundhog_day, grady_hutt, '').
starring_as(groundhog_day, regina_prokop, polka_dancer).
starring_as(groundhog_day, daniel_riggs, bachelor).
starring_as(groundhog_day, paul_terrien, groundhog_official).

released(hail_caesar, 2006).
directed(hail_caesar, ethan_coen).
directed(hail_caesar, joel_coen).

released(hearts_of_darkness_a_filmmaker_s_apocalypse, 1991).
directed(hearts_of_darkness_a_filmmaker_s_apocalypse, fax_bahr).
directed(hearts_of_darkness_a_filmmaker_s_apocalypse, eleanor_coppola).
directed(hearts_of_darkness_a_filmmaker_s_apocalypse, george_hickenlooper).
starring_as(hearts_of_darkness_a_filmmaker_s_apocalypse, john_milius, himself).
starring_as(hearts_of_darkness_a_filmmaker_s_apocalypse, sam_bottoms, himself).
starring_as(hearts_of_darkness_a_filmmaker_s_apocalypse, marlon_brando, himself).
starring_as(hearts_of_darkness_a_filmmaker_s_apocalypse, colleen_camp, herself).
starring_as(hearts_of_darkness_a_filmmaker_s_apocalypse, eleanor_coppola, herself).
starring_as(hearts_of_darkness_a_filmmaker_s_apocalypse, francis_ford_coppola, himself).
starring_as(hearts_of_darkness_a_filmmaker_s_apocalypse, gia_coppola, herself).
starring_as(hearts_of_darkness_a_filmmaker_s_apocalypse, roman_coppola, himself).
starring_as(hearts_of_darkness_a_filmmaker_s_apocalypse, sofia_coppola, herself).
starring_as(hearts_of_darkness_a_filmmaker_s_apocalypse, robert_de_niro, himself).
starring_as(hearts_of_darkness_a_filmmaker_s_apocalypse, robert_duvall, himself).
starring_as(hearts_of_darkness_a_filmmaker_s_apocalypse, laurence_fishburne, himself).
starring_as(hearts_of_darkness_a_filmmaker_s_apocalypse, harrison_ford, '').
starring_as(hearts_of_darkness_a_filmmaker_s_apocalypse, frederic_forrest, himself).
starring_as(hearts_of_darkness_a_filmmaker_s_apocalypse, albert_hall, himself).
starring_as(hearts_of_darkness_a_filmmaker_s_apocalypse, dennis_hopper, himself).
starring_as(hearts_of_darkness_a_filmmaker_s_apocalypse, george_lucas, himself).
starring_as(hearts_of_darkness_a_filmmaker_s_apocalypse, martin_sheen, himself).
starring_as(hearts_of_darkness_a_filmmaker_s_apocalypse, g_d_spradlin, himself).
starring_as(hearts_of_darkness_a_filmmaker_s_apocalypse, orson_welles, himself_from_1938_radio_broadcast).

released(the_hudsucker_proxy, 1994).
directed(the_hudsucker_proxy, ethan_coen).
directed(the_hudsucker_proxy, joel_coen).
starring_as(the_hudsucker_proxy, tim_robbins, norville_barnes).
starring_as(the_hudsucker_proxy, jennifer_jason_leigh, amy_archer).
starring_as(the_hudsucker_proxy, paul_newman, sidney_j_mussburger).
starring_as(the_hudsucker_proxy, charles_durning, waring_hudsucker).
starring_as(the_hudsucker_proxy, john_mahoney, chief_editor_manhattan_argus).
starring_as(the_hudsucker_proxy, jim_true_frost, buzz_the_elevator_operator).
starring_as(the_hudsucker_proxy, bill_cobbs, moses_the_clock_man).
starring_as(the_hudsucker_proxy, bruce_campbell, smitty_argus_reporter).
starring_as(the_hudsucker_proxy, harry_bugin, aloysius_mussburger_s_spy).
starring_as(the_hudsucker_proxy, john_seitz, bennie_the_cabbie).
starring_as(the_hudsucker_proxy, joe_grifasi, lou_the_cabbie).
starring_as(the_hudsucker_proxy, roy_brocksmith, board_member).
starring_as(the_hudsucker_proxy, john_wylie, board_member).
starring_as(the_hudsucker_proxy, i_m_hobson, board_member).
starring_as(the_hudsucker_proxy, gary_allen, board_member).
starring_as(the_hudsucker_proxy, john_scanlan, board_member).
starring_as(the_hudsucker_proxy, richard_woods, board_member).
starring_as(the_hudsucker_proxy, jerome_dempsey, board_member).
starring_as(the_hudsucker_proxy, peter_mcpherson, board_member).
starring_as(the_hudsucker_proxy, david_byrd, dr_hugo_bronfenbrenner).
starring_as(the_hudsucker_proxy, christopher_darga, mail_room_orienter).
starring_as(the_hudsucker_proxy, patrick_cranshaw, ancient_sorter).
starring_as(the_hudsucker_proxy, robert_weil, mail_room_boss).
starring_as(the_hudsucker_proxy, mary_lou_rosato, mussburger_s_secretary).
starring_as(the_hudsucker_proxy, ernest_sarracino, luigi_the_tailor).
starring_as(the_hudsucker_proxy, eleanor_glockner, mrs_mussburger).
starring_as(the_hudsucker_proxy, kathleen_perkins, mrs_braithwaite).
starring_as(the_hudsucker_proxy, joseph_marcus, sears_braithwaite_of_bullard).
starring_as(the_hudsucker_proxy, peter_gallagher, vic_tenetta_party_singer).
starring_as(the_hudsucker_proxy, noble_willingham, zebulon_cardoza).
starring_as(the_hudsucker_proxy, barbara_ann_grimes, mrs_cardoza).
starring_as(the_hudsucker_proxy, thom_noble, thorstenson_finlandson_finnish_stockholder).
starring_as(the_hudsucker_proxy, steve_buscemi, beatnik_barman_at_ann_s_440).
starring_as(the_hudsucker_proxy, william_duff_griffin, newsreel_scientist).
starring_as(the_hudsucker_proxy, anna_nicole_smith, za_za).
starring_as(the_hudsucker_proxy, pamela_everett, dream_dancer).
starring_as(the_hudsucker_proxy, arthur_bridgers, the_hula_hoop_kid).
starring_as(the_hudsucker_proxy, sam_raimi, hudsucker_brainstormer).
starring_as(the_hudsucker_proxy, john_cameron, hudsucker_brainstormer).
starring_as(the_hudsucker_proxy, skipper_duke, mr_grier).
starring_as(the_hudsucker_proxy, jay_kapner, mr_levin).
starring_as(the_hudsucker_proxy, jon_polito, mr_bumstead).
starring_as(the_hudsucker_proxy, richard_whiting, ancient_puzzler).
starring_as(the_hudsucker_proxy, linda_mccoy, coffee_shop_waitress).
starring_as(the_hudsucker_proxy, stan_adams, emcee).
starring_as(the_hudsucker_proxy, john_goodman, rockwell_newsreel_anouncer).
starring_as(the_hudsucker_proxy, joanne_pankow, newsreel_secretary).
starring_as(the_hudsucker_proxy, mario_todisco, norville_s_goon).
starring_as(the_hudsucker_proxy, colin_fickes, newsboy).
starring_as(the_hudsucker_proxy, dick_sasso, drunk_in_alley).
starring_as(the_hudsucker_proxy, jesse_brewer, mailroom_screamer).
starring_as(the_hudsucker_proxy, philip_loch, mailroom_screamer).
starring_as(the_hudsucker_proxy, stan_lichtenstein, mailroom_screamer).
starring_as(the_hudsucker_proxy, todd_alcott, mailroom_screamer).
starring_as(the_hudsucker_proxy, ace_o_connell, mailroom_screamer).
starring_as(the_hudsucker_proxy, richard_schiff, mailroom_screamer).
starring_as(the_hudsucker_proxy, frank_jeffries, mailroom_screamer).
starring_as(the_hudsucker_proxy, lou_criscuolo, mailroom_screamer).
starring_as(the_hudsucker_proxy, michael_earl_reid, mailroom_screamer).
starring_as(the_hudsucker_proxy, mike_starr, newsroom_reporter).
starring_as(the_hudsucker_proxy, david_hagar, newsroom_reporter).
starring_as(the_hudsucker_proxy, willie_reale, newsroom_reporter).
starring_as(the_hudsucker_proxy, harvey_meyer, newsroom_reporter).
starring_as(the_hudsucker_proxy, tom_toner, newsroom_reporter).
starring_as(the_hudsucker_proxy, david_fawcett, newsroom_reporter).
starring_as(the_hudsucker_proxy, jeff_still, newsreel_reporter).
starring_as(the_hudsucker_proxy, david_gould, newsreel_reporter).
starring_as(the_hudsucker_proxy, gil_pearson, newsreel_reporter).
starring_as(the_hudsucker_proxy, marc_garber, newsreel_reporter).
starring_as(the_hudsucker_proxy, david_massie, newsreel_reporter).
starring_as(the_hudsucker_proxy, mark_jeffrey_miller, newsreel_reporter).
starring_as(the_hudsucker_proxy, peter_siragusa, newsreel_reporter).
starring_as(the_hudsucker_proxy, nelson_george, newsreel_reporter).
starring_as(the_hudsucker_proxy, michael_houlihan, newsreel_reporter).
starring_as(the_hudsucker_proxy, ed_lillard, newsreel_reporter).
starring_as(the_hudsucker_proxy, wantland_sandel, new_year_s_mob).
starring_as(the_hudsucker_proxy, james_deuter, new_year_s_mob).
starring_as(the_hudsucker_proxy, roderick_peeples, new_year_s_mob).
starring_as(the_hudsucker_proxy, cynthia_baker, new_year_s_mob).
starring_as(the_hudsucker_proxy, jack_rooney, man_at_merchandise_mart).
starring_as(the_hudsucker_proxy, keith_schrader, businessman).

released(inside_monkey_zetterland, 1992).
directed(inside_monkey_zetterland, jefery_levy).
starring_as(inside_monkey_zetterland, steve_antin, monkey_zetterland).
starring_as(inside_monkey_zetterland, patricia_arquette, grace_zetterland).
starring_as(inside_monkey_zetterland, sandra_bernhard, imogene).
starring_as(inside_monkey_zetterland, sofia_coppola, cindy).
starring_as(inside_monkey_zetterland, tate_donovan, brent_zetterland).
starring_as(inside_monkey_zetterland, rupert_everett, sasha).
starring_as(inside_monkey_zetterland, katherine_helmond, honor_zetterland).
starring_as(inside_monkey_zetterland, bo_hopkins, mike_zetterland).
starring_as(inside_monkey_zetterland, ricki_lake, bella_the_stalker).
starring_as(inside_monkey_zetterland, debi_mazar, daphne).
starring_as(inside_monkey_zetterland, martha_plimpton, sofie).
starring_as(inside_monkey_zetterland, robin_antin, waitress).
starring_as(inside_monkey_zetterland, frances_bay, grandma).
starring_as(inside_monkey_zetterland, luca_bercovici, boot_guy).
starring_as(inside_monkey_zetterland, melissa_lechner, observation_psychiatrist).
starring_as(inside_monkey_zetterland, lance_loud, psychiatrist).
starring_as(inside_monkey_zetterland, chris_nash, police_officer).
starring_as(inside_monkey_zetterland, vivian_schilling, network_producer).
starring_as(inside_monkey_zetterland, blair_tefkin, brent_s_assistant).

released(intolerable_cruelty, 2003).
directed(intolerable_cruelty, ethan_coen).
directed(intolerable_cruelty, joel_coen).
starring_as(intolerable_cruelty, george_clooney, miles_massey).
starring_as(intolerable_cruelty, catherine_zeta_jones, marylin_rexroth).
starring_as(intolerable_cruelty, geoffrey_rush, donovan_donaly).
starring_as(intolerable_cruelty, cedric_the_entertainer, gus_petch).
starring_as(intolerable_cruelty, edward_herrmann, rex_rexroth).
starring_as(intolerable_cruelty, paul_adelstein, wrigley).
starring_as(intolerable_cruelty, richard_jenkins, freddy_bender).
starring_as(intolerable_cruelty, billy_bob_thornton, howard_d_doyle).
starring_as(intolerable_cruelty, julia_duffy, sarah_sorkin).
starring_as(intolerable_cruelty, jonathan_hadary, heinz_the_baron_krauss_von_espy).
starring_as(intolerable_cruelty, tom_aldredge, herb_myerson).
starring_as(intolerable_cruelty, stacey_travis, bonnie_donaly).
starring_as(intolerable_cruelty, jack_kyle, ollie_olerud).
starring_as(intolerable_cruelty, irwin_keyes, wheezy_joe).
starring_as(intolerable_cruelty, judith_drake, mrs_gutman).
starring_as(intolerable_cruelty, royce_d_applegate, mr_gutman).
starring_as(intolerable_cruelty, george_ives, mr_gutman_s_lawyer).
starring_as(intolerable_cruelty, booth_colman, gutman_trial_judge).
starring_as(intolerable_cruelty, kristin_dattilo, rex_s_young_woman).
starring_as(intolerable_cruelty, wendle_josepher, miles_receptionist).
starring_as(intolerable_cruelty, mary_pat_gleason, nero_s_waitress).
starring_as(intolerable_cruelty, mia_cottet, ramona_barcelona).
starring_as(intolerable_cruelty, kiersten_warren, claire_o_mara).
starring_as(intolerable_cruelty, rosey_brown, gus_s_pal).
starring_as(intolerable_cruelty, ken_sagoes, gus_s_pal).
starring_as(intolerable_cruelty, dale_e_turner, gus_s_pal).
starring_as(intolerable_cruelty, douglas_fisher, maitre_d).
starring_as(intolerable_cruelty, nicholas_shaffer, waiter).
starring_as(intolerable_cruelty, isabell_o_connor, judge_marva_munson).
starring_as(intolerable_cruelty, mary_gillis, court_reporter).
starring_as(intolerable_cruelty, colin_linden, father_scott).
starring_as(intolerable_cruelty, julie_osburn, stewardess).
starring_as(intolerable_cruelty, gary_marshal, las_vegas_waiter).
starring_as(intolerable_cruelty, blake_clark, convention_secretary).
starring_as(intolerable_cruelty, allan_trautman, convention_lawyer).
starring_as(intolerable_cruelty, kate_luyben, santa_fe_tart).
starring_as(intolerable_cruelty, kitana_baker, santa_fe_tart).
starring_as(intolerable_cruelty, camille_anderson, santa_fe_tart).
starring_as(intolerable_cruelty, tamie_sheffield, santa_fe_tart).
starring_as(intolerable_cruelty, bridget_marquardt, santa_fe_tart).
starring_as(intolerable_cruelty, emma_harrison, santa_fe_tart).
starring_as(intolerable_cruelty, john_bliss, mr_mackinnon).
starring_as(intolerable_cruelty, patrick_thomas_o_brien, bailiff).
starring_as(intolerable_cruelty, sean_fanton, bailiff).
starring_as(intolerable_cruelty, justine_baker, wedding_guest).
starring_as(intolerable_cruelty, bruce_campbell, soap_opera_starring_as_on_tv).
starring_as(intolerable_cruelty, barbara_kerr_condon, herb_myerson_s_private_nurse).
starring_as(intolerable_cruelty, jason_de_hoyos, gardener).
starring_as(intolerable_cruelty, larry_vigus, lawyer).
starring_as(intolerable_cruelty, susan_yeagley, tart_1).

released(the_ladykillers, 2004).
directed(the_ladykillers, ethan_coen).
directed(the_ladykillers, joel_coen).
starring_as(the_ladykillers, tom_hanks, professor_g_h_dorr).
starring_as(the_ladykillers, irma_p_hall, marva_munson).
starring_as(the_ladykillers, marlon_wayans, gawain_macsam).
starring_as(the_ladykillers, j_k_simmons, garth_pancake).
starring_as(the_ladykillers, tzi_ma, the_general).
starring_as(the_ladykillers, ryan_hurst, lump_hudson).
starring_as(the_ladykillers, diane_delano, mountain_girl).
starring_as(the_ladykillers, george_wallace, sheriff_wyner).
starring_as(the_ladykillers, john_mcconnell, deputy_sheriff).
starring_as(the_ladykillers, jason_weaver, weemack_funthes).
starring_as(the_ladykillers, stephen_root, fernand_gudge).
starring_as(the_ladykillers, lyne_odums, rosalie_funthes).
starring_as(the_ladykillers, walter_k_jordan, elron).
starring_as(the_ladykillers, george_anthony_bell, preacher).
starring_as(the_ladykillers, greg_grunberg, tv_commercial_director).
starring_as(the_ladykillers, hallie_singleton, craft_service).
starring_as(the_ladykillers, robert_baker, quarterback).
starring_as(the_ladykillers, blake_clark, football_coach).
starring_as(the_ladykillers, amad_jackson, doughnut_gangster).
starring_as(the_ladykillers, aldis_hodge, doughnut_gangster).
starring_as(the_ladykillers, freda_foh_shen, doughnut_woman).
starring_as(the_ladykillers, paula_martin, gawain_s_mama).
starring_as(the_ladykillers, jeremy_suarez, li_l_gawain).
starring_as(the_ladykillers, te_te_benn, gawain_s_sister).
starring_as(the_ladykillers, khalil_east, gawain_s_brother).
starring_as(the_ladykillers, jennifer_echols, waffle_hut_waitress).
starring_as(the_ladykillers, nita_norris, tea_lady).
starring_as(the_ladykillers, vivian_smallwood, tea_lady).
starring_as(the_ladykillers, maryn_tasco, tea_lady).
starring_as(the_ladykillers, muriel_whitaker, tea_lady).
starring_as(the_ladykillers, jessie_bailey, tea_lady).
starring_as(the_ladykillers, louisa_abernathy, church_voice).
starring_as(the_ladykillers, mildred_dumas, church_voice).
starring_as(the_ladykillers, al_fann, church_voice).
starring_as(the_ladykillers, mi_mi_green_fann, church_voice).
starring_as(the_ladykillers, maurice_watson, othar).
starring_as(the_ladykillers, bruce_campbell, humane_society_worker).
starring_as(the_ladykillers, michael_dotson, angry_football_fan).

released(lick_the_star, 1998).
directed(lick_the_star, sofia_coppola).
starring_as(lick_the_star, christina_turley, kate).
starring_as(lick_the_star, audrey_heaven, chloe).
starring_as(lick_the_star, julia_vanderham, rebecca).
starring_as(lick_the_star, lindsy_drummer, sara).
starring_as(lick_the_star, robert_schwartzman, greg).
starring_as(lick_the_star, rachael_vanni, wendy).
starring_as(lick_the_star, peter_bogdanovich, principal).
starring_as(lick_the_star, zoe_r_cassavetes, p_e_teacher).
starring_as(lick_the_star, anahid_nazarian, social_studies_teacher).
starring_as(lick_the_star, davia_nelson, english_teacher).
starring_as(lick_the_star, christianna_toler, nadine).
starring_as(lick_the_star, hilary_fleming, taco_girl).
starring_as(lick_the_star, eleanor_cummings, sixth_grader_p_e_victim).
starring_as(lick_the_star, anthony_desimone, snack_counter_victim).
starring_as(lick_the_star, aron_acord, sexy_boy).

released(lost_in_translation, 2003).
directed(lost_in_translation, sofia_coppola).
starring_as(lost_in_translation, scarlett_johansson, charlotte).
starring_as(lost_in_translation, bill_murray, bob_harris).
starring_as(lost_in_translation, akiko_takeshita, ms_kawasaki).
starring_as(lost_in_translation, kazuyoshi_minamimagoe, press_agent).
starring_as(lost_in_translation, kazuko_shibata, press_agent).
starring_as(lost_in_translation, take, press_agent).
starring_as(lost_in_translation, ryuichiro_baba, concierge).
starring_as(lost_in_translation, akira_yamaguchi, bellboy).
starring_as(lost_in_translation, catherine_lambert, jazz_singer).
starring_as(lost_in_translation, fran_ois_du_bois, sausalito_piano).
starring_as(lost_in_translation, tim_leffman, sausalito_guitar).
starring_as(lost_in_translation, gregory_pekar, american_businessman_1).
starring_as(lost_in_translation, richard_allen, american_businessman_2).
starring_as(lost_in_translation, giovanni_ribisi, john).
starring_as(lost_in_translation, diamond_yukai, commercial_director).
starring_as(lost_in_translation, jun_maki, suntory_client).
starring_as(lost_in_translation, nao_asuka, premium_fantasy_woman).
starring_as(lost_in_translation, tetsuro_naka, stills_photographer).
starring_as(lost_in_translation, kanako_nakazato, make_up_person).
starring_as(lost_in_translation, fumihiro_hayashi, charlie).
starring_as(lost_in_translation, hiroko_kawasaki, hiroko).
starring_as(lost_in_translation, daikon, bambie).
starring_as(lost_in_translation, anna_faris, kelly).
starring_as(lost_in_translation, asuka_shimuzu, kelly_s_translator).
starring_as(lost_in_translation, ikuko_takahashi, ikebana_instructor).
starring_as(lost_in_translation, koichi_tanaka, bartender_ny_bar).
starring_as(lost_in_translation, hugo_codaro, aerobics_instructor).
starring_as(lost_in_translation, akiko_monou, p_chan).
starring_as(lost_in_translation, akimitsu_naruyama, french_japanese_nightclub_patron).
starring_as(lost_in_translation, hiroshi_kawashima, bartender_nightclub).
starring_as(lost_in_translation, toshikawa_hiromi, hiromix).
starring_as(lost_in_translation, nobuhiko_kitamura, nobu).
starring_as(lost_in_translation, nao_kitman, nao).
starring_as(lost_in_translation, akira, hans).
starring_as(lost_in_translation, kunichi_nomura, kun).
starring_as(lost_in_translation, yasuhiko_hattori, charlie_s_friend).
starring_as(lost_in_translation, shigekazu_aida, mr_valentine).
starring_as(lost_in_translation, kazuo_yamada, hospital_receptionist).
starring_as(lost_in_translation, akira_motomura, old_man).
starring_as(lost_in_translation, osamu_shigematu, doctor).
starring_as(lost_in_translation, takashi_fujii, tv_host).
starring_as(lost_in_translation, kei_takyo, tv_translator).
starring_as(lost_in_translation, ryo_kondo, politician).
starring_as(lost_in_translation, yumi_ikeda, politician_s_aide).
starring_as(lost_in_translation, yumika_saki, politician_s_aide).
starring_as(lost_in_translation, yuji_okabe, politician_s_aide).
starring_as(lost_in_translation, diedrich_bollman, german_hotel_guest).
starring_as(lost_in_translation, georg_o_p_eschert, german_hotel_guest).
starring_as(lost_in_translation, mark_willms, carl_west).
starring_as(lost_in_translation, lisle_wilkerson, sexy_businesswoman).
starring_as(lost_in_translation, nancy_steiner, lydia_harris).

released(the_man_who_wasn_t_there, 2001).
directed(the_man_who_wasn_t_there, ethan_coen).
directed(the_man_who_wasn_t_there, joel_coen).
starring_as(the_man_who_wasn_t_there, billy_bob_thornton, ed_crane).
starring_as(the_man_who_wasn_t_there, frances_mcdormand, doris_crane).
starring_as(the_man_who_wasn_t_there, michael_badalucco, frank).
starring_as(the_man_who_wasn_t_there, james_gandolfini, dave_big_dave_brewster).
starring_as(the_man_who_wasn_t_there, katherine_borowitz, ann_nirdlinger).
starring_as(the_man_who_wasn_t_there, jon_polito, creighton_tolliver).
starring_as(the_man_who_wasn_t_there, scarlett_johansson, rachel_birdy_abundas).
starring_as(the_man_who_wasn_t_there, richard_jenkins, walter_abundas).
starring_as(the_man_who_wasn_t_there, tony_shalhoub, freddy_riedenschneider).
starring_as(the_man_who_wasn_t_there, christopher_kriesa, officer_persky).
starring_as(the_man_who_wasn_t_there, brian_haley, officer_pete_krebs).
starring_as(the_man_who_wasn_t_there, jack_mcgee, burns).
starring_as(the_man_who_wasn_t_there, gregg_binkley, the_new_man).
starring_as(the_man_who_wasn_t_there, alan_fudge, diedrickson).
starring_as(the_man_who_wasn_t_there, lilyan_chauvin, medium).
starring_as(the_man_who_wasn_t_there, adam_alexi_malle, jacques_carcanogues).
starring_as(the_man_who_wasn_t_there, ted_rooney, bingo_caller).
starring_as(the_man_who_wasn_t_there, abraham_benrubi, young_man).
starring_as(the_man_who_wasn_t_there, christian_ferratti, child).
starring_as(the_man_who_wasn_t_there, rhoda_gemignani, costanza).
starring_as(the_man_who_wasn_t_there, e_j_callahan, customer).
starring_as(the_man_who_wasn_t_there, brooke_smith, sobbing_prisoner).
starring_as(the_man_who_wasn_t_there, ron_ross, banker).
starring_as(the_man_who_wasn_t_there, hallie_singleton, waitress).
starring_as(the_man_who_wasn_t_there, jon_donnelly, gatto_eater).
starring_as(the_man_who_wasn_t_there, dan_martin, bailiff).
starring_as(the_man_who_wasn_t_there, nicholas_lanier, tony).
starring_as(the_man_who_wasn_t_there, tom_dahlgren, judge_1).
starring_as(the_man_who_wasn_t_there, booth_colman, judge_2).
starring_as(the_man_who_wasn_t_there, stanley_desantis, new_man_s_customer).
starring_as(the_man_who_wasn_t_there, peter_siragusa, bartender).
starring_as(the_man_who_wasn_t_there, christopher_mcdonald, macadam_salesman).
starring_as(the_man_who_wasn_t_there, rick_scarry, district_attorney).
starring_as(the_man_who_wasn_t_there, george_ives, lloyd_garroway).
starring_as(the_man_who_wasn_t_there, devon_cole_borisoff, swimming_boy).
starring_as(the_man_who_wasn_t_there, mary_bogue, prisoner_visitor).
starring_as(the_man_who_wasn_t_there, don_donati, pie_contest_timer).
starring_as(the_man_who_wasn_t_there, arthur_reeves, flophouse_clerk).
starring_as(the_man_who_wasn_t_there, michelle_weber, dancer).
starring_as(the_man_who_wasn_t_there, randi_pareira, dancer).
starring_as(the_man_who_wasn_t_there, robert_loftin, dancer).
starring_as(the_man_who_wasn_t_there, kenneth_hughes, dancer).
starring_as(the_man_who_wasn_t_there, gordon_hart, dancer).
starring_as(the_man_who_wasn_t_there, brenda_mae_hamilton, dancer).
starring_as(the_man_who_wasn_t_there, lloyd_gordon, dancer).
starring_as(the_man_who_wasn_t_there, leonard_crofoot, dancer).
starring_as(the_man_who_wasn_t_there, rita_bland, dancer).
starring_as(the_man_who_wasn_t_there, audrey_k_baranishyn, dancer).
starring_as(the_man_who_wasn_t_there, qyn_hughes, dancer).
starring_as(the_man_who_wasn_t_there, rachel_mcdonald, dancer).
starring_as(the_man_who_wasn_t_there, craig_berenson, jail_guy).
starring_as(the_man_who_wasn_t_there, joan_m_blair, prison_matron).
starring_as(the_man_who_wasn_t_there, geoffrey_gould, alpine_rope_toss_man).
starring_as(the_man_who_wasn_t_there, phil_hawn, man_in_courtroom).
starring_as(the_man_who_wasn_t_there, cherilyn_hayres, swing_dancer).
starring_as(the_man_who_wasn_t_there, john_michael_higgins, emergency_room_physician).
starring_as(the_man_who_wasn_t_there, monika_malmrose, crying_girl).
starring_as(the_man_who_wasn_t_there, peter_schrum, truck_driver).
starring_as(the_man_who_wasn_t_there, max_thayer, witness).

released(marie_antoinette, 2006).
directed(marie_antoinette, sofia_coppola).
starring_as(marie_antoinette, kirsten_dunst, marie_antoinette).
starring_as(marie_antoinette, jason_schwartzman, louis_xvi).
starring_as(marie_antoinette, rip_torn, king_louis_xv).
starring_as(marie_antoinette, judy_davis, comtesse_de_noailles).
starring_as(marie_antoinette, asia_argento, madame_du_barry).
starring_as(marie_antoinette, marianne_faithfull, maria_theresia).
starring_as(marie_antoinette, aurore_cl_ment, la_duchesse_de_chartres).
starring_as(marie_antoinette, guillaume_gallienne, comte_vergennes).
starring_as(marie_antoinette, clementine_poidatz, comtesse_de_provence).
starring_as(marie_antoinette, molly_shannon, anne_victoire).
starring_as(marie_antoinette, steve_coogan, count_mercy_d_argenteau).
starring_as(marie_antoinette, jamie_dornan, axel_von_fersen).
starring_as(marie_antoinette, shirley_henderson, aunt_sophie).
starring_as(marie_antoinette, jean_christophe_bouvet, duc_de_choiseul).
starring_as(marie_antoinette, filippo_bozotti, dimitri).
starring_as(marie_antoinette, sarah_adler, '').
starring_as(marie_antoinette, mathieu_amalric, man_at_the_masked_ball).
starring_as(marie_antoinette, rachel_berger, lady_m_b).
starring_as(marie_antoinette, xavier_bonastre, court_member).
starring_as(marie_antoinette, io_bottoms, lady_in_waiting_1).
starring_as(marie_antoinette, sol_ne_bouton, '').
starring_as(marie_antoinette, rose_byrne, yolande_martine_gabrielle_de_polastron_duchesse_de_polignac).
starring_as(marie_antoinette, alain_doutey, '').
starring_as(marie_antoinette, gilles_dufour, '').
starring_as(marie_antoinette, sabine_glaser, court_member).
starring_as(marie_antoinette, h_loise_godet, court_member).
starring_as(marie_antoinette, manon_grosset, une_page).
starring_as(marie_antoinette, philippe_h_li_s, king_s_aide_de_camp_2).
starring_as(marie_antoinette, arnaud_klein, garde_royal_royal_guard).
starring_as(marie_antoinette, aleksia_landeau, countesse_de_castelabjac).
starring_as(marie_antoinette, benjamin_lemaire, un_page).
starring_as(marie_antoinette, victor_loukianenko, le_valet_de_marie_antoinette).
starring_as(marie_antoinette, rapha_l_neal, garden_page).
starring_as(marie_antoinette, mary_nighy, '').
starring_as(marie_antoinette, al_weaver, '').

released(miller_s_crossing, 1990).
directed(miller_s_crossing, ethan_coen).
directed(miller_s_crossing, joel_coen).
starring_as(miller_s_crossing, gabriel_byrne, tom_reagan).
starring_as(miller_s_crossing, marcia_gay_harden, verna).
starring_as(miller_s_crossing, john_turturro, bernie_bernbaum).
starring_as(miller_s_crossing, jon_polito, johnny_caspar).
starring_as(miller_s_crossing, j_e_freeman, eddie_dane).
starring_as(miller_s_crossing, albert_finney, leo).
starring_as(miller_s_crossing, mike_starr, frankie).
starring_as(miller_s_crossing, al_mancini, tic_tac).
starring_as(miller_s_crossing, richard_woods, mayor_dale_levander).
starring_as(miller_s_crossing, thomas_toner, o_doole).
starring_as(miller_s_crossing, steve_buscemi, mink).
starring_as(miller_s_crossing, mario_todisco, clarence_drop_johnson).
starring_as(miller_s_crossing, olek_krupa, tad).
starring_as(miller_s_crossing, michael_jeter, adolph).
starring_as(miller_s_crossing, lanny_flaherty, terry).
starring_as(miller_s_crossing, jeanette_kontomitras, mrs_caspar).
starring_as(miller_s_crossing, louis_charles_mounicou_iii, johnny_caspar_jr).
starring_as(miller_s_crossing, john_mcconnell, cop__brian).
starring_as(miller_s_crossing, danny_aiello_iii, cop__delahanty).
starring_as(miller_s_crossing, helen_jolly, screaming_lady).
starring_as(miller_s_crossing, hilda_mclean, landlady).
starring_as(miller_s_crossing, monte_starr, gunman_in_leo_s_house).
starring_as(miller_s_crossing, don_picard, gunman_in_leo_s_house).
starring_as(miller_s_crossing, salvatore_h_tornabene, rug_daniels).
starring_as(miller_s_crossing, kevin_dearie, street_urchin).
starring_as(miller_s_crossing, michael_badalucco, caspar_s_driver).
starring_as(miller_s_crossing, charles_ferrara, caspar_s_butler).
starring_as(miller_s_crossing, esteban_fern_ndez, caspar_s_cousin).
starring_as(miller_s_crossing, george_fernandez, caspar_s_cousin).
starring_as(miller_s_crossing, charles_gunning, hitman_at_verna_s).
starring_as(miller_s_crossing, dave_drinkx, hitman_2).
starring_as(miller_s_crossing, david_darlow, lazarre_s_messenger).
starring_as(miller_s_crossing, robert_labrosse, lazarre_s_tough).
starring_as(miller_s_crossing, carl_rooney, lazarre_s_tough).
starring_as(miller_s_crossing, jack_harris, man_with_pipe_bomb).
starring_as(miller_s_crossing, jery_hewitt, son_of_erin).
starring_as(miller_s_crossing, sam_raimi, snickering_gunman).
starring_as(miller_s_crossing, john_schnauder_jr, cop_with_bullhorn).
starring_as(miller_s_crossing, zolly_levin, rabbi).
starring_as(miller_s_crossing, joey_ancona, boxer).
starring_as(miller_s_crossing, bill_raye, boxer).
starring_as(miller_s_crossing, william_preston_robertson, voice).
starring_as(miller_s_crossing, frances_mcdormand, mayor_s_secretary).

released(mission_impossible, 1996).
directed(mission_impossible, brian_de_palma).
starring_as(mission_impossible, tom_cruise, ethan_hunt).
starring_as(mission_impossible, jon_voight, jim_phelps).
starring_as(mission_impossible, emmanuelle_b_art, claire_phelps).
starring_as(mission_impossible, henry_czerny, eugene_kittridge).
starring_as(mission_impossible, jean_reno, franz_krieger).
starring_as(mission_impossible, ving_rhames, luther_stickell).
starring_as(mission_impossible, kristin_scott_thomas, sarah_davies).
starring_as(mission_impossible, vanessa_redgrave, max).
starring_as(mission_impossible, dale_dye, frank_barnes).
starring_as(mission_impossible, marcel_iures, golitsyn).
starring_as(mission_impossible, ion_caramitru, zozimov).
starring_as(mission_impossible, ingeborga_dapkunaite, hannah_williams).
starring_as(mission_impossible, valentina_yakunina, drunken_female_imf_agent).
starring_as(mission_impossible, marek_vasut, drunken_male_imf_agent).
starring_as(mission_impossible, nathan_osgood, kittridge_technician).
starring_as(mission_impossible, john_mclaughlin, tv_interviewer).
starring_as(mission_impossible, rolf_saxon, cia_analyst_william_donloe).
starring_as(mission_impossible, karel_dobry, matthias).
starring_as(mission_impossible, andreas_wisniewski, max_s_companion).
starring_as(mission_impossible, david_shaeffer, diplomat_rand_housman).
starring_as(mission_impossible, rudolf_pechan, mayor_brandl).
starring_as(mission_impossible, gaston_subert, jaroslav_reid).
starring_as(mission_impossible, ricco_ross, denied_area_security_guard).
starring_as(mission_impossible, mark_houghton, denied_area_security_guard).
starring_as(mission_impossible, bob_friend, sky_news_man).
starring_as(mission_impossible, annabel_mullion, flight_attendant).
starring_as(mission_impossible, garrick_hagon, cnn_reporter).
starring_as(mission_impossible, olegar_fedoro, kiev_room_agent).
starring_as(mission_impossible, sam_douglas, kiev_room_agent).
starring_as(mission_impossible, andrzej_borkowski, kiev_room_agent).
starring_as(mission_impossible, maya_dokic, kiev_room_agent).
starring_as(mission_impossible, carmela_marner, kiev_room_agent).
starring_as(mission_impossible, mimi_potworowska, kiev_room_agent).
starring_as(mission_impossible, jirina_trebick, cleaning_woman).
starring_as(mission_impossible, david_schneider, train_engineer).
starring_as(mission_impossible, helen_lindsay, female_executive_in_train).
starring_as(mission_impossible, pat_starr, cia_agent).
starring_as(mission_impossible, richard_d_sharp, cia_lobby_guard).
starring_as(mission_impossible, randall_paul, cia_escort_guard).
starring_as(mission_impossible, sue_doucette, cia_agent).
starring_as(mission_impossible, graydon_gould, public_official).
starring_as(mission_impossible, tony_vogel, m_i_5).
starring_as(mission_impossible, michael_rogers, large_man).
starring_as(mission_impossible, laura_brook, margaret_hunt).
starring_as(mission_impossible, morgan_deare, donald_hunt).
starring_as(mission_impossible, david_phelan, steward_on_train).
starring_as(mission_impossible, melissa_knatchbull, air_stewardess).
starring_as(mission_impossible, keith_campbell, fireman).
starring_as(mission_impossible, michael_cella, student).
starring_as(mission_impossible, emilio_estevez, jack_harmon).
starring_as(mission_impossible, john_knoll, passenger_on_train_in_tunnel).

released(no_country_for_old_men, 2007).
directed(no_country_for_old_men, joel_coen).

released(o_brother_where_art_thou, 2000).
directed(o_brother_where_art_thou, ethan_coen).
directed(o_brother_where_art_thou, joel_coen).
starring_as(o_brother_where_art_thou, george_clooney, ulysses_everett_mcgill).
starring_as(o_brother_where_art_thou, john_turturro, pete).
starring_as(o_brother_where_art_thou, tim_blake_nelson, delmar_o_donnell).
starring_as(o_brother_where_art_thou, john_goodman, big_dan_teague).
starring_as(o_brother_where_art_thou, holly_hunter, penny).
starring_as(o_brother_where_art_thou, chris_thomas_king, tommy_johnson).
starring_as(o_brother_where_art_thou, charles_durning, pappy_o_daniel).
starring_as(o_brother_where_art_thou, del_pentecost, junior_o_daniel).
starring_as(o_brother_where_art_thou, michael_badalucco, george_nelson).
starring_as(o_brother_where_art_thou, j_r_horne, pappy_s_staff).
starring_as(o_brother_where_art_thou, brian_reddy, pappy_s_staff).
starring_as(o_brother_where_art_thou, wayne_duvall, homer_stokes).
starring_as(o_brother_where_art_thou, ed_gale, the_little_man).
starring_as(o_brother_where_art_thou, ray_mckinnon, vernon_t_waldrip).
starring_as(o_brother_where_art_thou, daniel_von_bargen, sheriff_cooley_the_devil).
starring_as(o_brother_where_art_thou, royce_d_applegate, man_with_bullhorn).
starring_as(o_brother_where_art_thou, frank_collison, wash_hogwallop).
starring_as(o_brother_where_art_thou, quinn_gasaway, boy_hogwallop).
starring_as(o_brother_where_art_thou, lee_weaver, blind_seer).
starring_as(o_brother_where_art_thou, millford_fortenberry, pomade_vendor).
starring_as(o_brother_where_art_thou, stephen_root, radio_station_man).
starring_as(o_brother_where_art_thou, john_locke, mr_french).
starring_as(o_brother_where_art_thou, gillian_welch, soggy_bottom_customer).
starring_as(o_brother_where_art_thou, a_ray_ratliff, record_store_clerk).
starring_as(o_brother_where_art_thou, mia_tate, siren).
starring_as(o_brother_where_art_thou, musetta_vander, siren).
starring_as(o_brother_where_art_thou, christy_taylor, siren).
starring_as(o_brother_where_art_thou, april_hardcastle, waitress).
starring_as(o_brother_where_art_thou, michael_w_finnell, interrogator).
starring_as(o_brother_where_art_thou, georgia_rae_rainer, wharvey_gal).
starring_as(o_brother_where_art_thou, marianna_breland, wharvey_gal).
starring_as(o_brother_where_art_thou, lindsey_miller, wharvey_gal).
starring_as(o_brother_where_art_thou, natalie_shedd, wharvey_gal).
starring_as(o_brother_where_art_thou, john_mcconnell, woolworths_manager).
starring_as(o_brother_where_art_thou, issac_freeman, gravedigger).
starring_as(o_brother_where_art_thou, wilson_waters_jr, gravedigger).
starring_as(o_brother_where_art_thou, robert_hamlett, gravedigger).
starring_as(o_brother_where_art_thou, willard_cox, cox_family).
starring_as(o_brother_where_art_thou, evelyn_cox, cox_family).
starring_as(o_brother_where_art_thou, suzanne_cox, cox_family).
starring_as(o_brother_where_art_thou, sidney_cox, cox_family).
starring_as(o_brother_where_art_thou, buck_white, the_whites).
starring_as(o_brother_where_art_thou, sharon_white, the_whites).
starring_as(o_brother_where_art_thou, cheryl_white, the_whites).
starring_as(o_brother_where_art_thou, ed_snodderly, village_idiot).
starring_as(o_brother_where_art_thou, david_holt, village_idiot).
starring_as(o_brother_where_art_thou, jerry_douglas, dobro_player).
starring_as(o_brother_where_art_thou, christopher_francis, kkk_member).
starring_as(o_brother_where_art_thou, geoffrey_gould, head_of_mob).
starring_as(o_brother_where_art_thou, nathaniel_lee_jr, ice_boy_on_the_right_straw_hat).

released(the_outsiders, 1983).
directed(the_outsiders, francis_ford_coppola).
starring_as(the_outsiders, matt_dillon, dallas_dally_winston).
starring_as(the_outsiders, ralph_macchio, johnny_cade).
starring_as(the_outsiders, c_thomas_howell, ponyboy_curtis).
starring_as(the_outsiders, patrick_swayze, darrel_darry_curtis).
starring_as(the_outsiders, rob_lowe, sodapop_curtis).
starring_as(the_outsiders, emilio_estevez, keith_two_bit_mathews).
starring_as(the_outsiders, tom_cruise, steve_randle).
starring_as(the_outsiders, glenn_withrow, tim_shepard).
starring_as(the_outsiders, diane_lane, sherri_cherry_valance).
starring_as(the_outsiders, leif_garrett, bob_sheldon).
starring_as(the_outsiders, darren_dalton, randy_anderson).
starring_as(the_outsiders, michelle_meyrink, marcia).
starring_as(the_outsiders, gailard_sartain, jerry_wood).
starring_as(the_outsiders, tom_waits, buck_merrill).
starring_as(the_outsiders, william_smith, store_clerk).
starring_as(the_outsiders, tom_hillmann, greaser_in_concession_stand).
starring_as(the_outsiders, hugh_walkinshaw, soc_in_concession_stand).
starring_as(the_outsiders, sofia_coppola, little_girl).
starring_as(the_outsiders, teresa_wilkerson_hunt, woman_at_fire).
starring_as(the_outsiders, linda_nystedt, nurse).
starring_as(the_outsiders, s_e_hinton, nurse).
starring_as(the_outsiders, brent_beesley, suburb_guy).
starring_as(the_outsiders, john_meier, paul).
starring_as(the_outsiders, ed_jackson, motorcycle_cop).
starring_as(the_outsiders, daniel_r_suhart, orderly).
starring_as(the_outsiders, heather_langenkamp, '').

released(paris_je_t_aime, 2006).
directed(paris_je_t_aime, olivier_assayas).
directed(paris_je_t_aime, fr_d_ric_auburtin).
directed(paris_je_t_aime, christoffer_boe).
directed(paris_je_t_aime, sylvain_chomet).
directed(paris_je_t_aime, ethan_coen).
directed(paris_je_t_aime, joel_coen).
directed(paris_je_t_aime, isabel_coixet).
directed(paris_je_t_aime, alfonso_cuar_n).
directed(paris_je_t_aime, g_rard_depardieu).
directed(paris_je_t_aime, jean_luc_godard).
directed(paris_je_t_aime, richard_lagravenese).
directed(paris_je_t_aime, anne_marie_mi_ville).
directed(paris_je_t_aime, vincenzo_natali).
directed(paris_je_t_aime, alexander_payne).
directed(paris_je_t_aime, walter_salles).
directed(paris_je_t_aime, oliver_schmitz).
directed(paris_je_t_aime, ettore_scola).
directed(paris_je_t_aime, nobuhiro_suwa).
directed(paris_je_t_aime, daniela_thomas).
directed(paris_je_t_aime, tom_tykwer).
directed(paris_je_t_aime, gus_van_sant).
starring_as(paris_je_t_aime, emilie_ohana, the_young_parisian_recurrent_character).
starring_as(paris_je_t_aime, julie_bataille, julie_segment_1st_arrondissement).
starring_as(paris_je_t_aime, steve_buscemi, the_tourist_segment_1st_arrondissement).
starring_as(paris_je_t_aime, axel_kiener, axel_segment_1st_arrondissement).
starring_as(paris_je_t_aime, juliette_binoche, the_mother_segment_2nd_arrondissement).
starring_as(paris_je_t_aime, willem_dafoe, the_cow_boy_segment_2nd_arrondissement).
starring_as(paris_je_t_aime, marianne_faithfull, segment_4th_arrondissement).
starring_as(paris_je_t_aime, elias_mcconnell, eli_segment_4th_arrondissement).
starring_as(paris_je_t_aime, gaspard_ulliel, gaspar_segment_4th_arrondissement).
starring_as(paris_je_t_aime, ben_gazzara, ben_segment_6th_arrondissement).
starring_as(paris_je_t_aime, gena_rowlands, gena_segment_6th_arrondissement).
starring_as(paris_je_t_aime, yolande_moreau, female_mime_segment_7th_arrondissement).
starring_as(paris_je_t_aime, paul_putner, male_mime_segment_7th_arrondissement).
starring_as(paris_je_t_aime, olga_kurylenko, the_femme_fatale_segment_8th_arrondissement).
starring_as(paris_je_t_aime, fanny_ardant, fanny_forestier_segment_9th_arrondissement).
starring_as(paris_je_t_aime, bob_hoskins, bob_leander_segment_9th_arrondissement).
starring_as(paris_je_t_aime, melchior_beslon, thomas_segment_10th_arrondissement).
starring_as(paris_je_t_aime, natalie_portman, francine_segment_10th_arrondissement).
starring_as(paris_je_t_aime, javier_c_mara, the_doctor_segment_12th_arrondissement).
starring_as(paris_je_t_aime, isabella_rossellini, the_wife_segment_12th_arrondissement).
starring_as(paris_je_t_aime, leonor_watling, segment_12th_arrondissement).
starring_as(paris_je_t_aime, camille_japy, anna_segment_15th_arrondissement).
starring_as(paris_je_t_aime, nick_nolte, vincent_segment_17th_arrondissement).
starring_as(paris_je_t_aime, ludivine_sagnier, claire_segment_17th_arrondissement).
starring_as(paris_je_t_aime, seydou_boro, hassan_segment_19th_arrondissement).
starring_as(paris_je_t_aime, a_ssa_ma_ga, sophie_segment_19th_arrondissement).

released(peggy_sue_got_married, 1986).
directed(peggy_sue_got_married, francis_ford_coppola).
starring_as(peggy_sue_got_married, kathleen_turner, peggy_sue_kelcher_peggy_sue_bodell).
starring_as(peggy_sue_got_married, nicolas_cage, charlie_bodell).
starring_as(peggy_sue_got_married, barry_miller, richard_norvik).
starring_as(peggy_sue_got_married, catherine_hicks, carol_heath).
starring_as(peggy_sue_got_married, joan_allen, maddy_nagle).
starring_as(peggy_sue_got_married, kevin_j_o_connor, michael_fitzsimmons).
starring_as(peggy_sue_got_married, jim_carrey, walter_getz).
starring_as(peggy_sue_got_married, lisa_jane_persky, delores_dodge).
starring_as(peggy_sue_got_married, lucinda_jenney, rosalie_testa).
starring_as(peggy_sue_got_married, wil_shriner, arthur_nagle).
starring_as(peggy_sue_got_married, barbara_harris, evelyn_kelcher).
starring_as(peggy_sue_got_married, don_murray, jack_kelcher).
starring_as(peggy_sue_got_married, sofia_coppola, nancy_kelcher).
starring_as(peggy_sue_got_married, maureen_o_sullivan, elizabeth_alvorg).
starring_as(peggy_sue_got_married, leon_ames, barney_alvorg).
starring_as(peggy_sue_got_married, randy_bourne, scott_bodell).
starring_as(peggy_sue_got_married, helen_hunt, beth_bodell).
starring_as(peggy_sue_got_married, don_stark, doug_snell).
starring_as(peggy_sue_got_married, marshall_crenshaw, reunion_band).
starring_as(peggy_sue_got_married, chris_donato, reunion_band).
starring_as(peggy_sue_got_married, robert_crenshaw, reunion_band).
starring_as(peggy_sue_got_married, tom_teeley, reunion_band).
starring_as(peggy_sue_got_married, graham_maby, reunion_band).
starring_as(peggy_sue_got_married, ken_grantham, mr_snelgrove).
starring_as(peggy_sue_got_married, ginger_taylor, janet).
starring_as(peggy_sue_got_married, sigrid_wurschmidt, sharon).
starring_as(peggy_sue_got_married, glenn_withrow, terry).
starring_as(peggy_sue_got_married, harry_basil, leon).
starring_as(peggy_sue_got_married, john_carradine, leo).
starring_as(peggy_sue_got_married, sachi_parker, lisa).
starring_as(peggy_sue_got_married, vivien_straus, sandy).
starring_as(peggy_sue_got_married, morgan_upton, mr_gilford).
starring_as(peggy_sue_got_married, dr_lewis_leibovich, dr_daly).
starring_as(peggy_sue_got_married, bill_bonham, drunk).
starring_as(peggy_sue_got_married, joe_lerer, drunk_creep).
starring_as(peggy_sue_got_married, barbara_oliver, nurse).
starring_as(peggy_sue_got_married, martin_scott, the_four_mations).
starring_as(peggy_sue_got_married, marcus_scott, the_four_mations).
starring_as(peggy_sue_got_married, carl_lockett, the_four_mations).
starring_as(peggy_sue_got_married, tony_saunders, the_four_mations).
starring_as(peggy_sue_got_married, vincent_lars, the_four_mations).
starring_as(peggy_sue_got_married, larry_e_vann, the_four_mations).
starring_as(peggy_sue_got_married, lawrence_menkin, elderly_gentleman).
starring_as(peggy_sue_got_married, daniel_r_suhart, chinese_waiter).
starring_as(peggy_sue_got_married, leslie_hilsinger, majorette).
starring_as(peggy_sue_got_married, al_nalbandian, lodge_member).
starring_as(peggy_sue_got_married, dan_leegant, lodge_member).
starring_as(peggy_sue_got_married, ron_cook, lodge_member).
starring_as(peggy_sue_got_married, mary_leichtling, reunion_receptionist).
starring_as(peggy_sue_got_married, cynthia_brian, reunion_woman_2).
starring_as(peggy_sue_got_married, michael_x_martin, '').
starring_as(peggy_sue_got_married, mary_mitchel, '').

released(raising_arizona, 1987).
directed(raising_arizona, ethan_coen).
directed(raising_arizona, joel_coen).
starring_as(raising_arizona, nicolas_cage, h_i_mcdonnough).
starring_as(raising_arizona, holly_hunter, edwina_ed_mcdonnough).
starring_as(raising_arizona, trey_wilson, nathan_arizona_huffhines_sr).
starring_as(raising_arizona, john_goodman, gale_snoats).
starring_as(raising_arizona, william_forsythe, evelle_snoats).
starring_as(raising_arizona, sam_mcmurray, glen).
starring_as(raising_arizona, frances_mcdormand, dot).
starring_as(raising_arizona, randall_tex_cobb, leonard_smalls).
starring_as(raising_arizona, t_j_kuhn, nathan_arizona_jr).
starring_as(raising_arizona, lynne_dumin_kitei, florence_arizona).
starring_as(raising_arizona, peter_benedek, prison_counselor).
starring_as(raising_arizona, charles_lew_smith, nice_old_grocery_man).
starring_as(raising_arizona, warren_keith, younger_fbi_agent).
starring_as(raising_arizona, henry_kendrick, older_fbi_agent).
starring_as(raising_arizona, sidney_dawson, moses_ear_bending_cellmate).
starring_as(raising_arizona, richard_blake, parole_board_chairman).
starring_as(raising_arizona, troy_nabors, parole_board_member).
starring_as(raising_arizona, mary_seibel, parole_board_member).
starring_as(raising_arizona, john_o_donnal, hayseed_in_the_pickup).
starring_as(raising_arizona, keith_jandacek, whitey).
starring_as(raising_arizona, warren_forsythe, minister).
starring_as(raising_arizona, ruben_young, trapped_convict).
starring_as(raising_arizona, dennis_sullivan, policeman_in_arizona_house).
starring_as(raising_arizona, richard_alexander, policeman_in_arizona_house).
starring_as(raising_arizona, rusty_lee, feisty_hayseed).
starring_as(raising_arizona, james_yeater, fingerprint_technician).
starring_as(raising_arizona, bill_andres, reporter).
starring_as(raising_arizona, carver_barns, reporter).
starring_as(raising_arizona, margaret_h_mccormack, unpainted_arizona_secretary).
starring_as(raising_arizona, bill_rocz, newscaster).
starring_as(raising_arizona, mary_f_glenn, payroll_cashier).
starring_as(raising_arizona, jeremy_babendure, scamp_with_squirt_gun).
starring_as(raising_arizona, bill_dobbins, adoption_agent).
starring_as(raising_arizona, ralph_norton, gynecologist).
starring_as(raising_arizona, henry_tank, mopping_convict).
starring_as(raising_arizona, frank_outlaw, supermarket_manager).
starring_as(raising_arizona, todd_michael_rodgers, varsity_nathan_jr).
starring_as(raising_arizona, m_emmet_walsh, machine_shop_ear_bender).
starring_as(raising_arizona, robert_gray, glen_and_dot_s_kid).
starring_as(raising_arizona, katie_thrasher, glen_and_dot_s_kid).
starring_as(raising_arizona, derek_russell, glen_and_dot_s_kid).
starring_as(raising_arizona, nicole_russell, glen_and_dot_s_kid).
starring_as(raising_arizona, zachary_sanders, glen_and_dot_s_kid).
starring_as(raising_arizona, noell_sanders, glen_and_dot_s_kid).
starring_as(raising_arizona, cody_ranger, arizona_quint).
starring_as(raising_arizona, jeremy_arendt, arizona_quint).
starring_as(raising_arizona, ashley_hammon, arizona_quint).
starring_as(raising_arizona, crystal_hiller, arizona_quint).
starring_as(raising_arizona, olivia_hughes, arizona_quint).
starring_as(raising_arizona, emily_malin, arizona_quint).
starring_as(raising_arizona, melanie_malin, arizona_quint).
starring_as(raising_arizona, craig_mclaughlin, arizona_quint).
starring_as(raising_arizona, adam_savageau, arizona_quint).
starring_as(raising_arizona, benjamin_savageau, arizona_quint).
starring_as(raising_arizona, david_schneider, arizona_quint).
starring_as(raising_arizona, michael_stewart, arizona_quint).
starring_as(raising_arizona, william_preston_robertson, amazing_voice).
starring_as(raising_arizona, ron_francis_cobert, reporter_1).

released(rumble_fish, 1983).
directed(rumble_fish, francis_ford_coppola).
starring_as(rumble_fish, matt_dillon, rusty_james).
starring_as(rumble_fish, mickey_rourke, the_motorcycle_boy).
starring_as(rumble_fish, diane_lane, patty).
starring_as(rumble_fish, dennis_hopper, father).
starring_as(rumble_fish, diana_scarwid, cassandra).
starring_as(rumble_fish, vincent_spano, steve).
starring_as(rumble_fish, nicolas_cage, smokey).
starring_as(rumble_fish, chris_penn, b_j_jackson).
starring_as(rumble_fish, laurence_fishburne, midget).
starring_as(rumble_fish, william_smith, patterson_the_cop).
starring_as(rumble_fish, michael_higgins, mr_harrigan).
starring_as(rumble_fish, glenn_withrow, biff_wilcox).
starring_as(rumble_fish, tom_waits, benny).
starring_as(rumble_fish, herb_rice, black_pool_player).
starring_as(rumble_fish, maybelle_wallace, late_pass_clerk).
starring_as(rumble_fish, nona_manning, patty_s_mom).
starring_as(rumble_fish, sofia_coppola, donna_patty_s_sister).
starring_as(rumble_fish, gian_carlo_coppola, cousin_james).
starring_as(rumble_fish, s_e_hinton, hooker_on_strip).
starring_as(rumble_fish, emmett_brown, mr_dobson).
starring_as(rumble_fish, tracey_walter, alley_mugger_1).
starring_as(rumble_fish, lance_guecia, alley_mugger_2).
starring_as(rumble_fish, bob_maras, policeman).
starring_as(rumble_fish, j_t_turner, math_teacher).
starring_as(rumble_fish, keeva_clayton, lake_girl_1).
starring_as(rumble_fish, kirsten_hayden, lake_girl_2).
starring_as(rumble_fish, karen_parker, lake_girl_3).
starring_as(rumble_fish, sussannah_darcy, lake_girl_4).
starring_as(rumble_fish, kristi_somers, lake_girl_5).
starring_as(rumble_fish, heather_langenkamp, '').

released(spies_like_us, 1985).
directed(spies_like_us, john_landis).
starring_as(spies_like_us, chevy_chase, emmett_fitz_hume).
starring_as(spies_like_us, dan_aykroyd, austin_millbarge).
starring_as(spies_like_us, steve_forrest, general_sline).
starring_as(spies_like_us, donna_dixon, karen_boyer).
starring_as(spies_like_us, bruce_davison, ruby).
starring_as(spies_like_us, bernie_casey, colonel_rhumbus).
starring_as(spies_like_us, william_prince, keyes).
starring_as(spies_like_us, tom_hatten, general_miegs).
starring_as(spies_like_us, frank_oz, test_monitor).
starring_as(spies_like_us, charles_mckeown, jerry_hadley).
starring_as(spies_like_us, james_daughton, bob_hodges).
starring_as(spies_like_us, jim_staahl, bud_schnelker).
starring_as(spies_like_us, vanessa_angel, russian_rocket_crew).
starring_as(spies_like_us, svetlana_plotnikova, russian_rocket_crew).
starring_as(spies_like_us, bjarne_thomsen, russian_rocket_crew).
starring_as(spies_like_us, sergei_rousakov, russian_rocket_crew).
starring_as(spies_like_us, garrick_dombrovski, russian_rocket_crew).
starring_as(spies_like_us, terry_gilliam, dr_imhaus).
starring_as(spies_like_us, costa_gavras, tadzhik_highway_patrol).
starring_as(spies_like_us, seva_novgorodtsev, tadzhik_highway_patrol).
starring_as(spies_like_us, stephen_hoye, captain_hefling).
starring_as(spies_like_us, ray_harryhausen, dr_marston).
starring_as(spies_like_us, mark_stewart, ace_tomato_courier).
starring_as(spies_like_us, sean_daniel, ace_tomato_driver).
starring_as(spies_like_us, jeff_harding, fitz_hume_s_associate).
starring_as(spies_like_us, heidi_sorenson, alice_fitz_hume_s_supervisor).
starring_as(spies_like_us, margo_random, reporter).
starring_as(spies_like_us, douglas_lambert, reporter).
starring_as(spies_like_us, christopher_malcolm, jumpmaster).
starring_as(spies_like_us, terrance_conder, soldier_1).
starring_as(spies_like_us, matt_frewer, soldier_2).
starring_as(spies_like_us, tony_cyrus, the_khan).
starring_as(spies_like_us, gusti_bogok, dr_la_fong).
starring_as(spies_like_us, derek_meddings, dr_stinson).
starring_as(spies_like_us, robert_paynter, dr_gill).
starring_as(spies_like_us, bob_hope, golfer).
starring_as(spies_like_us, gurdial_sira, the_khan_s_brother).
starring_as(spies_like_us, joel_coen, drive_in_security).
starring_as(spies_like_us, sam_raimi, drive_in_security).
starring_as(spies_like_us, michael_apted, ace_tomato_agent).
starring_as(spies_like_us, b_b_king, ace_tomato_agent).
starring_as(spies_like_us, larry_cohen, ace_tomato_agent).
starring_as(spies_like_us, martin_brest, drive_in_security).
starring_as(spies_like_us, ricco_ross, wamp_guard).
starring_as(spies_like_us, richard_sharpe, wamp_technician).
starring_as(spies_like_us, stuart_milligan, wamp_technician).
starring_as(spies_like_us, sally_anlauf, wamp_technician).
starring_as(spies_like_us, john_daveikis, russian_border_guard).
starring_as(spies_like_us, laurence_bilzerian, russian_border_guard).
starring_as(spies_like_us, richard_kruk, russian_border_guard).
starring_as(spies_like_us, heather_henson, teenage_girl).
starring_as(spies_like_us, erin_folsey, teenage_girl).
starring_as(spies_like_us, bob_swaim, special_forces_commander).
starring_as(spies_like_us, edwin_newman, himself).
starring_as(spies_like_us, nancy_gair, student).

released(star_wars_episode_i__the_phantom_menace, 1999).
directed(star_wars_episode_i__the_phantom_menace, george_lucas).
starring_as(star_wars_episode_i__the_phantom_menace, liam_neeson, qui_gon_jinn).
starring_as(star_wars_episode_i__the_phantom_menace, ewan_mcgregor, obi_wan_kenobi).
starring_as(star_wars_episode_i__the_phantom_menace, natalie_portman, queen_padm_naberrie_amidala).
starring_as(star_wars_episode_i__the_phantom_menace, jake_lloyd, anakin_skywalker).
starring_as(star_wars_episode_i__the_phantom_menace, pernilla_august, shmi_skywalker).
starring_as(star_wars_episode_i__the_phantom_menace, frank_oz, yoda).
starring_as(star_wars_episode_i__the_phantom_menace, ian_mcdiarmid, senator_palpatine).
starring_as(star_wars_episode_i__the_phantom_menace, oliver_ford_davies, gov_sio_bibble).
starring_as(star_wars_episode_i__the_phantom_menace, hugh_quarshie, capt_panaka).
starring_as(star_wars_episode_i__the_phantom_menace, ahmed_best, jar_jar_binks).
starring_as(star_wars_episode_i__the_phantom_menace, anthony_daniels, c_3po).
starring_as(star_wars_episode_i__the_phantom_menace, kenny_baker, r2_d2).
starring_as(star_wars_episode_i__the_phantom_menace, terence_stamp, supreme_chancellor_valorum).
starring_as(star_wars_episode_i__the_phantom_menace, brian_blessed, boss_nass).
starring_as(star_wars_episode_i__the_phantom_menace, andrew_secombe, watto).
starring_as(star_wars_episode_i__the_phantom_menace, ray_park, darth_maul).
starring_as(star_wars_episode_i__the_phantom_menace, lewis_macleod, sebulba).
starring_as(star_wars_episode_i__the_phantom_menace, steven_spiers, capt_tarpals).
starring_as(star_wars_episode_i__the_phantom_menace, silas_carson, viceroy_nute_gunray_ki_adi_mundi_lott_dodd_radiant_vii_pilot).
starring_as(star_wars_episode_i__the_phantom_menace, ralph_brown, ric_oli).
starring_as(star_wars_episode_i__the_phantom_menace, celia_imrie, fighter_pilot_bravo_5).
starring_as(star_wars_episode_i__the_phantom_menace, benedict_taylor, fighter_pilot_bravo_2).
starring_as(star_wars_episode_i__the_phantom_menace, clarence_smith, fighter_pilot_bravo_3).
starring_as(star_wars_episode_i__the_phantom_menace, karol_cristina_da_silva, rab).
starring_as(star_wars_episode_i__the_phantom_menace, samuel_l_jackson, mace_windu).
starring_as(star_wars_episode_i__the_phantom_menace, dominic_west, palace_guard).
starring_as(star_wars_episode_i__the_phantom_menace, liz_wilson, eirta).
starring_as(star_wars_episode_i__the_phantom_menace, candice_orwell, yan).
starring_as(star_wars_episode_i__the_phantom_menace, sofia_coppola, sach).
starring_as(star_wars_episode_i__the_phantom_menace, keira_knightley, sab__queen_s_decoy).
starring_as(star_wars_episode_i__the_phantom_menace, bronagh_gallagher, radiant_vii_captain).
starring_as(star_wars_episode_i__the_phantom_menace, john_fensom, tc_14).
starring_as(star_wars_episode_i__the_phantom_menace, greg_proops, beed).
starring_as(star_wars_episode_i__the_phantom_menace, scott_capurro, fode).
starring_as(star_wars_episode_i__the_phantom_menace, margaret_towner, jira).
starring_as(star_wars_episode_i__the_phantom_menace, dhruv_chanchani, kitster).
starring_as(star_wars_episode_i__the_phantom_menace, oliver_walpole, seek).
starring_as(star_wars_episode_i__the_phantom_menace, katie_lucas, amee).
starring_as(star_wars_episode_i__the_phantom_menace, megan_udall, melee).
starring_as(star_wars_episode_i__the_phantom_menace, hassani_shapi, eeth_koth).
starring_as(star_wars_episode_i__the_phantom_menace, gin_clarke, adi_gallia).
starring_as(star_wars_episode_i__the_phantom_menace, khan_bonfils, saesee_tiin).
starring_as(star_wars_episode_i__the_phantom_menace, michelle_taylor, yarael_poof).
starring_as(star_wars_episode_i__the_phantom_menace, michaela_cottrell, even_piell).
starring_as(star_wars_episode_i__the_phantom_menace, dipika_o_neill_joti, depa_billaba).
starring_as(star_wars_episode_i__the_phantom_menace, phil_eason, yaddle).
starring_as(star_wars_episode_i__the_phantom_menace, mark_coulier, aks_moe).
starring_as(star_wars_episode_i__the_phantom_menace, lindsay_duncan, tc_14).
starring_as(star_wars_episode_i__the_phantom_menace, peter_serafinowicz, darth_maul).
starring_as(star_wars_episode_i__the_phantom_menace, james_taylor, rune_haako).
starring_as(star_wars_episode_i__the_phantom_menace, chris_sanders, daultay_dofine).
starring_as(star_wars_episode_i__the_phantom_menace, toby_longworth, sen_lott_dodd_gragra).
starring_as(star_wars_episode_i__the_phantom_menace, marc_silk, aks_moe).
starring_as(star_wars_episode_i__the_phantom_menace, amanda_lucas, tey_how).
starring_as(star_wars_episode_i__the_phantom_menace, amy_allen, twi_lek_senatorial_aide_dvd_deleted_scenes).
starring_as(star_wars_episode_i__the_phantom_menace, don_bies, pod_race_mechanic).
starring_as(star_wars_episode_i__the_phantom_menace, trisha_biggar, orn_free_taa_s_aide).
starring_as(star_wars_episode_i__the_phantom_menace, jerome_blake, rune_haako_mas_amedda_oppo_rancisis_orn_free_taa).
starring_as(star_wars_episode_i__the_phantom_menace, michonne_bourriague, aurra_sing).
starring_as(star_wars_episode_i__the_phantom_menace, ben_burtt, naboo_courier).
starring_as(star_wars_episode_i__the_phantom_menace, doug_chiang, flag_bearer).
starring_as(star_wars_episode_i__the_phantom_menace, rob_coleman, pod_race_spectator).
starring_as(star_wars_episode_i__the_phantom_menace, roman_coppola, senate_guard).
starring_as(star_wars_episode_i__the_phantom_menace, warwick_davis, wald_pod_race_spectator_mos_espa_citizen).
starring_as(star_wars_episode_i__the_phantom_menace, c_michael_easton, pod_race_spectator).
starring_as(star_wars_episode_i__the_phantom_menace, john_ellis, pod_race_spectator).
starring_as(star_wars_episode_i__the_phantom_menace, ira_feiedman, naboo_courier).
starring_as(star_wars_episode_i__the_phantom_menace, joss_gower, naboo_fighter_pilot).
starring_as(star_wars_episode_i__the_phantom_menace, raymond_griffiths, gonk_droid).
starring_as(star_wars_episode_i__the_phantom_menace, nathan_hamill, pod_race_spectator_naboo_palace_guard).
starring_as(star_wars_episode_i__the_phantom_menace, tim_harrington, extra_naboo_security_gaurd).
starring_as(star_wars_episode_i__the_phantom_menace, nifa_hindes, ann_gella).
starring_as(star_wars_episode_i__the_phantom_menace, nishan_hindes, tann_gella).
starring_as(star_wars_episode_i__the_phantom_menace, john_knoll, lt_rya_kirsch_bravo_4_flag_bearer).
starring_as(star_wars_episode_i__the_phantom_menace, madison_lloyd, princess_ellie).
starring_as(star_wars_episode_i__the_phantom_menace, dan_madsen, kaadu_handler).
starring_as(star_wars_episode_i__the_phantom_menace, iain_mccaig, orn_free_taa_s_aide).
starring_as(star_wars_episode_i__the_phantom_menace, rick_mccallum, naboo_courier).
starring_as(star_wars_episode_i__the_phantom_menace, lorne_peterson, mos_espa_citizen).
starring_as(star_wars_episode_i__the_phantom_menace, alan_ruscoe, plo_koon_bib_foruna_daultay_dofine).
starring_as(star_wars_episode_i__the_phantom_menace, steve_sansweet, naboo_courier).
starring_as(star_wars_episode_i__the_phantom_menace, jeff_shay, pod_race_spectator).
starring_as(star_wars_episode_i__the_phantom_menace, christian_simpson, bravo_6).
starring_as(star_wars_episode_i__the_phantom_menace, paul_martin_smith, naboo_courier).
starring_as(star_wars_episode_i__the_phantom_menace, scott_squires, naboo_speeder_driver).
starring_as(star_wars_episode_i__the_phantom_menace, tom_sylla, battle_droid).
starring_as(star_wars_episode_i__the_phantom_menace, danny_wagner, mawhonic).
starring_as(star_wars_episode_i__the_phantom_menace, dwayne_williams, naboo_courier).
starring_as(star_wars_episode_i__the_phantom_menace, matthew_wood, bib_fortuna_voice_of_ody_mandrell).
starring_as(star_wars_episode_i__the_phantom_menace, bob_woods, naboo_courier).

released(torrance_rises, 1999).
directed(torrance_rises, lance_bangs).
directed(torrance_rises, spike_jonze).
directed(torrance_rises, torrance_community_dance_group).
starring_as(torrance_rises, spike_jonze, richard_coufey).
starring_as(torrance_rises, michelle_adams_meeker, herself).
starring_as(torrance_rises, ashley_barnett, herself).
starring_as(torrance_rises, dee_buchanan, herself).
starring_as(torrance_rises, roman_coppola, roman_coppola).
starring_as(torrance_rises, sofia_coppola, herself).
starring_as(torrance_rises, renee_diamond, herself).
starring_as(torrance_rises, eminem, eminem).
starring_as(torrance_rises, alvin_gaines_molina, himself).
starring_as(torrance_rises, janeane_garofalo, janeane_garofalo).
starring_as(torrance_rises, michael_gier, himself).
starring_as(torrance_rises, richard_koufey, himself).
starring_as(torrance_rises, byron_s_loyd, himself).
starring_as(torrance_rises, allison_lynch, herself).
starring_as(torrance_rises, madonna, madonna).
starring_as(torrance_rises, kevin_l_maher, himself).
starring_as(torrance_rises, tony_maxwell, himself).
starring_as(torrance_rises, lonne_g_moretton, herself).
starring_as(torrance_rises, joyeve_palffy, herself).
starring_as(torrance_rises, kristine_petrucione, herself).
starring_as(torrance_rises, regis_philbin, regis_philbin).
starring_as(torrance_rises, cynthia_m_reed, herself).
starring_as(torrance_rises, chris_rock, chris_rock).
starring_as(torrance_rises, michael_rooney, michael_rooney).
starring_as(torrance_rises, justin_ross, himself).
starring_as(torrance_rises, danette_e_sheppard, herself).
starring_as(torrance_rises, fatboy_slim, fatboy_slim).
starring_as(torrance_rises, will_smith, will_smith).
starring_as(torrance_rises, frank_stancati, himself).
starring_as(torrance_rises, tim_szczepanski, himself).
starring_as(torrance_rises, michelle_weber, herself).

released(the_usual_suspects, 1995).
directed(the_usual_suspects, bryan_singer).
starring_as(the_usual_suspects, stephen_baldwin, michael_mcmanus).
starring_as(the_usual_suspects, gabriel_byrne, dean_keaton).
starring_as(the_usual_suspects, benicio_del_toro, fred_fenster).
starring_as(the_usual_suspects, kevin_pollak, todd_hockney).
starring_as(the_usual_suspects, kevin_spacey, roger_verbal_kint).
starring_as(the_usual_suspects, chazz_palminteri, dave_kujan_us_customs).
starring_as(the_usual_suspects, pete_postlethwaite, kobayashi).
starring_as(the_usual_suspects, suzy_amis, edie_finneran).
starring_as(the_usual_suspects, giancarlo_esposito, jack_baer_fbi).
starring_as(the_usual_suspects, dan_hedaya, sgt_geoffrey_jeff_rabin).
starring_as(the_usual_suspects, paul_bartel, smuggler).
starring_as(the_usual_suspects, carl_bressler, saul_berg).
starring_as(the_usual_suspects, phillip_simon, fortier).
starring_as(the_usual_suspects, jack_shearer, renault).
starring_as(the_usual_suspects, christine_estabrook, dr_plummer).
starring_as(the_usual_suspects, clark_gregg, dr_walters).
starring_as(the_usual_suspects, morgan_hunter, arkosh_kovash).
starring_as(the_usual_suspects, ken_daly, translator).
starring_as(the_usual_suspects, michelle_clunie, sketch_artist).
starring_as(the_usual_suspects, louis_lombardi, strausz).
starring_as(the_usual_suspects, frank_medrano, rizzi).
starring_as(the_usual_suspects, ron_gilbert, daniel_metzheiser_dept_of_justice).
starring_as(the_usual_suspects, vito_d_ambrosio, arresting_officer).
starring_as(the_usual_suspects, gene_lythgow, cop_on_pier).
starring_as(the_usual_suspects, robert_elmore, bodyguard_1).
starring_as(the_usual_suspects, david_powledge, bodyguard_2).
starring_as(the_usual_suspects, bob_pennetta, bodyguard_3).
starring_as(the_usual_suspects, billy_bates, bodyguard_4).
starring_as(the_usual_suspects, smadar_hanson, keyser_s_wife).
starring_as(the_usual_suspects, castulo_guerra, arturro_marquez).
starring_as(the_usual_suspects, peter_rocca, jaime_arturro_s_bodyguard).
starring_as(the_usual_suspects, bert_williams, old_cop_in_property).
starring_as(the_usual_suspects, john_gillespie, '').
starring_as(the_usual_suspects, peter_greene, redfoot_the_fence).
starring_as(the_usual_suspects, christopher_mcquarrie, interrogation_cop).
starring_as(the_usual_suspects, scott_b_morgan, keyser_s_ze_in_flashback).

released(the_virgin_suicides, 1999).
directed(the_virgin_suicides, sofia_coppola).
starring_as(the_virgin_suicides, james_woods, mr_lisbon).
starring_as(the_virgin_suicides, kathleen_turner, mrs_lisbon).
starring_as(the_virgin_suicides, kirsten_dunst, lux_lisbon).
starring_as(the_virgin_suicides, josh_hartnett, trip_fontaine).
starring_as(the_virgin_suicides, michael_par, adult_trip_fontaine).
starring_as(the_virgin_suicides, scott_glenn, father_moody).
starring_as(the_virgin_suicides, danny_devito, dr_horniker).
starring_as(the_virgin_suicides, a_j_cook, mary_lisbon).
starring_as(the_virgin_suicides, hanna_r_hall, cecilia_lisbon).
starring_as(the_virgin_suicides, leslie_hayman, therese_lisbon).
starring_as(the_virgin_suicides, chelse_swain, bonnie_lisbon).
starring_as(the_virgin_suicides, anthony_desimone, chase_buell).
starring_as(the_virgin_suicides, lee_kagan, david_barker).
starring_as(the_virgin_suicides, robert_schwartzman, paul_baldino).
starring_as(the_virgin_suicides, noah_shebib, parkie_denton).
starring_as(the_virgin_suicides, jonathan_tucker, tim_weiner).
starring_as(the_virgin_suicides, joe_roncetti, kevin_head).
starring_as(the_virgin_suicides, hayden_christensen, joe_hill_conley).
starring_as(the_virgin_suicides, chris_hale, peter_sisten).
starring_as(the_virgin_suicides, joe_dinicol, dominic_palazzolo).
starring_as(the_virgin_suicides, suki_kaiser, lydia_perl).
starring_as(the_virgin_suicides, dawn_greenhalgh, mrs_scheer).
starring_as(the_virgin_suicides, allen_stewart_coates, mr_scheer).
starring_as(the_virgin_suicides, sherry_miller, mrs_buell).
starring_as(the_virgin_suicides, jonathon_whittaker, mr_buell).
starring_as(the_virgin_suicides, michelle_duquet, mrs_denton).
starring_as(the_virgin_suicides, murray_mcrae, mr_denton).
starring_as(the_virgin_suicides, roberta_hanley, mrs_weiner).
starring_as(the_virgin_suicides, paul_sybersma, joe_larson).
starring_as(the_virgin_suicides, susan_sybersma, mrs_larson).
starring_as(the_virgin_suicides, peter_snider, trip_s_dad).
starring_as(the_virgin_suicides, gary_brennan, donald).
starring_as(the_virgin_suicides, charles_boyland, curt_van_osdol).
starring_as(the_virgin_suicides, dustin_ladd, chip_willard).
starring_as(the_virgin_suicides, kristin_fairlie, amy_schraff).
starring_as(the_virgin_suicides, melody_johnson, julie).
starring_as(the_virgin_suicides, sheyla_molho, danielle).
starring_as(the_virgin_suicides, ashley_ainsworth, sheila_davis).
starring_as(the_virgin_suicides, courtney_hawkrigg, grace).
starring_as(the_virgin_suicides, fran_ois_klanfer, doctor).
starring_as(the_virgin_suicides, mackenzie_lawrenz, jim_czeslawski).
starring_as(the_virgin_suicides, tim_hall, kurt_siles).
starring_as(the_virgin_suicides, amos_crawley, john).
starring_as(the_virgin_suicides, andrew_gillies, principal_woodhouse).
starring_as(the_virgin_suicides, marilyn_smith, mrs_woodhouse).
starring_as(the_virgin_suicides, sally_cahill, mrs_hedlie).
starring_as(the_virgin_suicides, tracy_ferencz, nurse).
starring_as(the_virgin_suicides, scot_denton, mr_o_conner).
starring_as(the_virgin_suicides, catherine_swing, mrs_o_conner).
starring_as(the_virgin_suicides, timothy_adams, buzz_romano).
starring_as(the_virgin_suicides, michael_michaelessi, parks_department_foreman).
starring_as(the_virgin_suicides, sarah_minhas, wanda_brown).
starring_as(the_virgin_suicides, megan_kennedy, cheerleader).
starring_as(the_virgin_suicides, sandi_stahlbrand, meredith_thompson).
starring_as(the_virgin_suicides, neil_girvan, drunk_man_in_pool).
starring_as(the_virgin_suicides, jaya_karsemeyer, gloria).
starring_as(the_virgin_suicides, leah_straatsma, rannie).
starring_as(the_virgin_suicides, mark_polley, cemetery_worker_1).
starring_as(the_virgin_suicides, kirk_gonnsen, cemetery_worker_2).
starring_as(the_virgin_suicides, marianne_moroney, teacher).
starring_as(the_virgin_suicides, anne_wessels, woman_in_chiffon).
starring_as(the_virgin_suicides, derek_boyes, football_grieving_teacher).
starring_as(the_virgin_suicides, john_buchan, john_lydia_s_boss).
starring_as(the_virgin_suicides, mandy_lee_jones, student).
starring_as(the_virgin_suicides, giovanni_ribisi, narrator).

released(an_american_rhapsody, 2001).
directed(an_american_rhapsody, va_g_rdos).
starring_as(an_american_rhapsody, scarlett_johansson, suzanne_sandor_at_15).
starring_as(an_american_rhapsody, nastassja_kinski, margit_sandor).
starring_as(an_american_rhapsody, raffaella_b_ns_gi, suzanne_infant).
starring_as(an_american_rhapsody, tony_goldwyn, peter_sandor).
starring_as(an_american_rhapsody, gnes_b_nfalvy, helen).
starring_as(an_american_rhapsody, zolt_n_seress, george).
starring_as(an_american_rhapsody, klaudia_szab, maria_at_4).
starring_as(an_american_rhapsody, zsolt_zagoni, russian_soldier).
starring_as(an_american_rhapsody, andr_s_sz_ke, istvan).
starring_as(an_american_rhapsody, erzsi_p_sztor, ilus).
starring_as(an_american_rhapsody, carlos_laszlo_weiner, boy_on_train_boy_at_party).
starring_as(an_american_rhapsody, bori_kereszturi, suzanne_at_3).
starring_as(an_american_rhapsody, p_ter_k_lloy_moln_r, avo_officer).
starring_as(an_american_rhapsody, zsuzsa_czink_czi, teri).
starring_as(an_american_rhapsody, bal_zs_galk, jeno).
starring_as(an_american_rhapsody, kata_dob, claire).
starring_as(an_american_rhapsody, va_sz_r_nyi, eva).
starring_as(an_american_rhapsody, don_pugsley, cafe_supervisor).
starring_as(an_american_rhapsody, vladimir_mashkov, frank).
starring_as(an_american_rhapsody, lisa_jane_persky, pattie).
starring_as(an_american_rhapsody, colleen_camp, dottie).
starring_as(an_american_rhapsody, kelly_endresz_banlaki, suzanne_at_6).
starring_as(an_american_rhapsody, imola_g_sp_r, stewardess).
starring_as(an_american_rhapsody, tatyana_kanavka, girl_in_airport).
starring_as(an_american_rhapsody, mae_whitman, maria_at_10).
starring_as(an_american_rhapsody, lorna_scott, neighbor_with_poodle).
starring_as(an_american_rhapsody, sandra_staggs, saleswoman).
starring_as(an_american_rhapsody, jacqueline_steiger, betty).
starring_as(an_american_rhapsody, robert_lesser, harold).
starring_as(an_american_rhapsody, lou_beach, party_goer).
starring_as(an_american_rhapsody, marlee_jackson, sheila_at_7).
starring_as(an_american_rhapsody, emmy_rossum, sheila_at_15).
starring_as(an_american_rhapsody, timothy_everett_moore, paul).
starring_as(an_american_rhapsody, joshua_dov, richard).
starring_as(an_american_rhapsody, larisa_oleynik, maria_sandor_at_18).
starring_as(an_american_rhapsody, kati_b_cs, woman_1_at_market).
starring_as(an_american_rhapsody, zsuzsa_sz_ger, woman_2_at_market).
starring_as(an_american_rhapsody, andras_banlaki, '').
starring_as(an_american_rhapsody, va_g_rdos, suzanne_sandor_in_family_picture_age_6).
starring_as(an_american_rhapsody, peter_janosi, german_customs_officer).

released(the_black_dahlia, 2006).
directed(the_black_dahlia, brian_de_palma).
starring_as(the_black_dahlia, josh_hartnett, ofcr_dwight_bucky_bleichert).
starring_as(the_black_dahlia, scarlett_johansson, kay_lake).
starring_as(the_black_dahlia, hilary_swank, madeleine_linscott).
starring_as(the_black_dahlia, aaron_eckhart, sgt_leland_lee_blanchard).
starring_as(the_black_dahlia, mia_kirshner, elizabeth_short).
starring_as(the_black_dahlia, graham_norris, sgt_john_carter).
starring_as(the_black_dahlia, judith_benezra, '').
starring_as(the_black_dahlia, richard_brake, bobby_dewitt).
starring_as(the_black_dahlia, kevin_dunn, cleo_short).
starring_as(the_black_dahlia, troy_evans, '').
starring_as(the_black_dahlia, william_finley, '').
starring_as(the_black_dahlia, patrick_fischler, a_d_a_ellis_loew).
starring_as(the_black_dahlia, michael_p_flannigan, desk_sergeant).
starring_as(the_black_dahlia, gregg_henry, '').
starring_as(the_black_dahlia, claudia_katz, frolic_bartender).
starring_as(the_black_dahlia, john_kavanagh, emmet_linscott).
starring_as(the_black_dahlia, laura_kightlinger, hooker).
starring_as(the_black_dahlia, steven_koller, male_nurse).
starring_as(the_black_dahlia, angus_macinnes, '').
starring_as(the_black_dahlia, david_mcdivitt, cop).
starring_as(the_black_dahlia, rose_mcgowan, sheryl_saddon).
starring_as(the_black_dahlia, victor_mcguire, '').
starring_as(the_black_dahlia, rachel_miner, '').
starring_as(the_black_dahlia, stephanie_l_moore, pretty_girl).
starring_as(the_black_dahlia, james_otis, '').
starring_as(the_black_dahlia, david_raibon, black_man).
starring_as(the_black_dahlia, jemima_rooper, '').
starring_as(the_black_dahlia, anthony_russell, '').
starring_as(the_black_dahlia, joost_scholte, gi_pick_up).
starring_as(the_black_dahlia, pepe_serna, '').
starring_as(the_black_dahlia, fiona_shaw, '').
starring_as(the_black_dahlia, joey_slotnick, '').
starring_as(the_black_dahlia, mike_starr, russ_millard).

released(fall, 1997).
directed(fall, eric_schaeffer).
starring_as(fall, eric_schaeffer, michael).
starring_as(fall, amanda_de_cadenet, sarah).
starring_as(fall, rudolf_martin, phillipe).
starring_as(fall, francie_swift, robin).
starring_as(fall, lisa_vidal, sally).
starring_as(fall, roberta_maxwell, joan_alterman).
starring_as(fall, jose_yenque, scasse).
starring_as(fall, josip_kuchan, zsarko).
starring_as(fall, scarlett_johansson, little_girl).
starring_as(fall, ellen_barber, woman).
starring_as(fall, willis_burks_ii, baja).
starring_as(fall, scott_cohen, derick).
starring_as(fall, a_j_lopez, bellboy).
starring_as(fall, casper_martinez, church_goer).
starring_as(fall, arthur_j_nascarella, anthony_the_maitre_d).
starring_as(fall, john_o_nelson, guy_by_window).
starring_as(fall, amaury_nolasco, waiter).
starring_as(fall, marc_sebastian, popparazi).
starring_as(fall, evan_thompson, priest).
starring_as(fall, larry_weiss, paparazzi).

released(eight_legged_freaks, 2002).
directed(eight_legged_freaks, ellory_elkayem).
starring_as(eight_legged_freaks, david_arquette, chris_mccormick).
starring_as(eight_legged_freaks, kari_wuhrer, sheriff_samantha_parker).
starring_as(eight_legged_freaks, scott_terra, mike_parker).
starring_as(eight_legged_freaks, scarlett_johansson, ashley_parker).
starring_as(eight_legged_freaks, doug_e_doug, harlan_griffith).
starring_as(eight_legged_freaks, rick_overton, deputy_pete_willis).
starring_as(eight_legged_freaks, leon_rippy, wade).
starring_as(eight_legged_freaks, matt_czuchry, bret).
starring_as(eight_legged_freaks, jay_arlen_jones, leon).
starring_as(eight_legged_freaks, eileen_ryan, gladys).
starring_as(eight_legged_freaks, riley_smith, randy).
starring_as(eight_legged_freaks, matt_holwick, larry).
starring_as(eight_legged_freaks, jane_edith_wilson, emma).
starring_as(eight_legged_freaks, jack_moore, amos).
starring_as(eight_legged_freaks, roy_gaintner, floyd).
starring_as(eight_legged_freaks, don_champlin, leroy).
starring_as(eight_legged_freaks, john_storey, mark).
starring_as(eight_legged_freaks, david_earl_waterman, norman).
starring_as(eight_legged_freaks, randi_j_klein, waitress_1).
starring_as(eight_legged_freaks, terey_summers, waitress_2).
starring_as(eight_legged_freaks, john_ennis, cop_1).
starring_as(eight_legged_freaks, ryan_c_benson, cop_2).
starring_as(eight_legged_freaks, bruiser, himself).
starring_as(eight_legged_freaks, tom_noonan, joshua_taft).

released(ghost_world, 2000).
directed(ghost_world, terry_zwigoff).
starring_as(ghost_world, thora_birch, enid).
starring_as(ghost_world, scarlett_johansson, rebecca).
starring_as(ghost_world, steve_buscemi, seymour).
starring_as(ghost_world, brad_renfro, josh).
starring_as(ghost_world, illeana_douglas, roberta_allsworth).
starring_as(ghost_world, bob_balaban, enid_s_dad).
starring_as(ghost_world, stacey_travis, dana).
starring_as(ghost_world, charles_c_stevenson_jr, norman).
starring_as(ghost_world, dave_sheridan, doug).
starring_as(ghost_world, tom_mcgowan, joe).
starring_as(ghost_world, debra_azar, melora).
starring_as(ghost_world, brian_george, sidewinder_boss).
starring_as(ghost_world, pat_healy, john_ellis).
starring_as(ghost_world, rini_bell, graduation_speaker).
starring_as(ghost_world, t_j_thyne, todd).
starring_as(ghost_world, ezra_buzzington, weird_al).
starring_as(ghost_world, lindsey_girardot, vanilla__graduation_rapper).
starring_as(ghost_world, joy_bisco, jade__graduation_rapper).
starring_as(ghost_world, venus_demilo, ebony__graduation_rapper).
starring_as(ghost_world, ashley_peldon, margaret__art_class).
starring_as(ghost_world, chachi_pittman, phillip__art_class).
starring_as(ghost_world, janece_jordan, black_girl__art_class).
starring_as(ghost_world, kaileigh_martin, snotty_girl__art_class).
starring_as(ghost_world, alexander_fors, hippy_boy__art_class).
starring_as(ghost_world, marc_vann, jerome_the_angry_guy__record_collector).
starring_as(ghost_world, james_sie, steven_the_asian_guy__record_collector).
starring_as(ghost_world, paul_keith, paul_the_fussy_guy__record_collector).
starring_as(ghost_world, david_cross, gerrold_the_pushy_guy__record_collector).
starring_as(ghost_world, j_j_bad_boy_jones, fred_chatman__blues_club).
starring_as(ghost_world, dylan_jones, red_haired_girl__blues_club).
starring_as(ghost_world, martin_grey, m_c__blues_club).
starring_as(ghost_world, steve_pierson, blueshammer_member__blues_club).
starring_as(ghost_world, jake_la_botz, blueshammer_member__blues_club).
starring_as(ghost_world, johnny_irion, blueshammer_member__blues_club).
starring_as(ghost_world, nate_wood, blueshammer_member__blues_club).
starring_as(ghost_world, charles_schneider, joey_mccobb_the_stand_up_comic).
starring_as(ghost_world, sid_hillman, zine_o_phobia_creep).
starring_as(ghost_world, joshua_wheeler, zine_o_phobia_creep).
starring_as(ghost_world, patrick_fischler, masterpiece_video_clerk).
starring_as(ghost_world, daniel_graves, masterpiece_video_customer).
starring_as(ghost_world, matt_doherty, masterpiece_video_employee).
starring_as(ghost_world, joel_michaely, porno_cashier).
starring_as(ghost_world, debi_derryberry, rude_coffee_customer).
starring_as(ghost_world, joseph_sikora, reggae_fan).
starring_as(ghost_world, brett_gilbert, alien_autopsy_guy).
starring_as(ghost_world, alex_solowitz, cineplex_manager).
starring_as(ghost_world, tony_ketcham, alcoholic_customer).
starring_as(ghost_world, mary_bogue, popcorn_customer).
starring_as(ghost_world, brian_jacobs, soda_customer).
starring_as(ghost_world, patrick_yonally, garage_sale_hipster).
starring_as(ghost_world, lauren_bowles, angry_garage_sale_woman).
starring_as(ghost_world, lorna_scott, phyllis_the_art_show_curator).
starring_as(ghost_world, jeff_murray, roberta_s_colleague).
starring_as(ghost_world, jerry_rector, dana_s_co_worker).
starring_as(ghost_world, john_bunnell, seymour_s_boss).
starring_as(ghost_world, diane_salinger, psychiatrist).
starring_as(ghost_world, anna_berger, seymour_s_mother).
starring_as(ghost_world, bruce_glover, feldman_the_wheel_chair_guy).
starring_as(ghost_world, joan_m_blair, lady_crossing_street_slowly).
starring_as(ghost_world, michael_chanslor, orange_colored_sky_keyboarder_graduation_band).
starring_as(ghost_world, teri_garr, maxine).
starring_as(ghost_world, alan_heitz, driver).
starring_as(ghost_world, ernie_hernandez, orange_colored_sky_guitarist_graduation_band).
starring_as(ghost_world, felice_hernandez, orange_colored_sky_singer_graduation_band).
starring_as(ghost_world, larry_klein, orange_colored_sky_drummer_graduation_band).
starring_as(ghost_world, james_matusky, reggae_fan_2).
starring_as(ghost_world, edward_t_mcavoy, mr_satanist).
starring_as(ghost_world, margaret_kontra_palmer, lady_at_garage_sale).
starring_as(ghost_world, larry_parker, orange_colored_sky_bassist_graduation_band).
starring_as(ghost_world, greg_wendell_reid, yuppie_1).
starring_as(ghost_world, michelle_marie_white, mom_in_convenience_store).
starring_as(ghost_world, peter_yarrow, himself).

released(a_good_woman, 2004).
directed(a_good_woman, mike_barker).
starring_as(a_good_woman, helen_hunt, mrs_erlynne).
starring_as(a_good_woman, scarlett_johansson, meg_windermere).
starring_as(a_good_woman, milena_vukotic, contessa_lucchino).
starring_as(a_good_woman, stephen_campbell_moore, lord_darlington).
starring_as(a_good_woman, mark_umbers, robert_windemere).
starring_as(a_good_woman, roger_hammond, cecil).
starring_as(a_good_woman, john_standing, dumby).
starring_as(a_good_woman, tom_wilkinson, tuppy).
starring_as(a_good_woman, giorgia_massetti, alessandra).
starring_as(a_good_woman, diana_hardcastle, lady_plymdale).
starring_as(a_good_woman, shara_orano, francesca).
starring_as(a_good_woman, jane_how, mrs_stutfield).
starring_as(a_good_woman, bruce_mcguire, waiter_joe).
starring_as(a_good_woman, michael_stromme, hotel_desk_clerk).
starring_as(a_good_woman, antonio_barbaro, paulo).
starring_as(a_good_woman, valentina_d_uva, giuseppina_glove_shop_girl).
starring_as(a_good_woman, filippo_santoro, old_man).
starring_as(a_good_woman, augusto_zucchi, antique_shop_keeper).
starring_as(a_good_woman, carolina_levi, dress_shop_salesgirl).
starring_as(a_good_woman, daniela_stanga, dress_shop_owner).
starring_as(a_good_woman, arianna_mansi, stella_s_maid_1).
starring_as(a_good_woman, camilla_bertocci, stella_s_maid_2).
starring_as(a_good_woman, nichola_aigner, mrs_gowper).

released(if_lucy_fell, 1996).
directed(if_lucy_fell, eric_schaeffer).
starring_as(if_lucy_fell, sarah_jessica_parker, lucy_ackerman).
starring_as(if_lucy_fell, eric_schaeffer, joe_macgonaughgill).
starring_as(if_lucy_fell, ben_stiller, bwick_elias).
starring_as(if_lucy_fell, elle_macpherson, jane_lindquist).
starring_as(if_lucy_fell, james_rebhorn, simon_ackerman).
starring_as(if_lucy_fell, robert_john_burke, handsome_man).
starring_as(if_lucy_fell, david_thornton, ted).
starring_as(if_lucy_fell, bill_sage, dick).
starring_as(if_lucy_fell, dominic_chianese, al).
starring_as(if_lucy_fell, scarlett_johansson, emily).
starring_as(if_lucy_fell, michael_storms, sam).
starring_as(if_lucy_fell, jason_myers, billy).
starring_as(if_lucy_fell, emily_hart, eddy).
starring_as(if_lucy_fell, paul_greco, rene).
starring_as(if_lucy_fell, mujibur_rahman, counterman).
starring_as(if_lucy_fell, sirajul_islam, counterman).
starring_as(if_lucy_fell, ben_lin, chinese_messenger).
starring_as(if_lucy_fell, alice_spivak, elegant_middle_aged_woman).
starring_as(if_lucy_fell, lisa_gerstein, saleswoman).
starring_as(if_lucy_fell, molly_schulman, kid).
starring_as(if_lucy_fell, peter_walker, bag_man).
starring_as(if_lucy_fell, bradley_jenkel, neighbor).
starring_as(if_lucy_fell, brian_keane, man_in_gallery).
starring_as(if_lucy_fell, amanda_kravat, woman_in_park).

released(home_alone_3, 1997).
directed(home_alone_3, raja_gosnell).
starring_as(home_alone_3, alex_d_linz, alex_pruitt).
starring_as(home_alone_3, olek_krupa, peter_beaupre).
starring_as(home_alone_3, rya_kihlstedt, alice_ribbons).
starring_as(home_alone_3, lenny_von_dohlen, burton_jernigan).
starring_as(home_alone_3, david_thornton, earl_unger).
starring_as(home_alone_3, haviland_morris, karen_pruitt).
starring_as(home_alone_3, kevin_kilner, jack_pruitt).
starring_as(home_alone_3, marian_seldes, mrs_hess).
starring_as(home_alone_3, seth_smith, stan_pruitt).
starring_as(home_alone_3, scarlett_johansson, molly_pruitt).
starring_as(home_alone_3, christopher_curry, agent_stuckey).
starring_as(home_alone_3, baxter_harris, police_captain).
starring_as(home_alone_3, james_saito, chinese_mob_boss).
starring_as(home_alone_3, kevin_gudahl, techie).
starring_as(home_alone_3, richard_hamilton, taxi_driver).
starring_as(home_alone_3, freeman_coffey, recruiting_officer).
starring_as(home_alone_3, krista_lally, dispatcher).
starring_as(home_alone_3, neil_flynn, police_officer_1).
starring_as(home_alone_3, tony_mockus_jr, police_officer_2).
starring_as(home_alone_3, pat_healy, agent_rogers).
starring_as(home_alone_3, james_chisem, police_officer_3).
starring_as(home_alone_3, darwin_harris, photographer).
starring_as(home_alone_3, adrianne_duncan, flight_attendant).
starring_as(home_alone_3, sharon_sachs, annoying_woman).
starring_as(home_alone_3, joseph_luis_caballero, security_guard).
starring_as(home_alone_3, larry_c_tankson, cart_driver).
starring_as(home_alone_3, jennifer_a_daley, police_photographer_2).
starring_as(home_alone_3, darren_t_knaus, parrot).
starring_as(home_alone_3, caryn_cheever, ticketing_agent).
starring_as(home_alone_3, sarah_godshaw, latchkey_girl).
starring_as(home_alone_3, andy_john_g_kalkounos, police_officer_1).
starring_as(home_alone_3, zachary_lee, johnny_allen).
starring_as(home_alone_3, kelly_ann_marquart, girl_on_sidewalk).

released(the_horse_whisperer, 1998).
directed(the_horse_whisperer, robert_redford).
starring_as(the_horse_whisperer, robert_redford, tom_booker).
starring_as(the_horse_whisperer, kristin_scott_thomas, annie_maclean).
starring_as(the_horse_whisperer, sam_neill, robert_maclean).
starring_as(the_horse_whisperer, dianne_wiest, diane_booker).
starring_as(the_horse_whisperer, scarlett_johansson, grace_maclean).
starring_as(the_horse_whisperer, chris_cooper, frank_booker).
starring_as(the_horse_whisperer, cherry_jones, liz_hammond).
starring_as(the_horse_whisperer, ty_hillman, joe_booker).
starring_as(the_horse_whisperer, kate_bosworth, judith).
starring_as(the_horse_whisperer, austin_schwarz, twin_1).
starring_as(the_horse_whisperer, dustin_schwarz, twin_2).
starring_as(the_horse_whisperer, jeanette_nolan, ellen_booker).
starring_as(the_horse_whisperer, steve_frye, hank).
starring_as(the_horse_whisperer, don_edwards, smokey).
starring_as(the_horse_whisperer, jessalyn_gilsig, lucy_annie_s_assistant).
starring_as(the_horse_whisperer, william_buddy_byrd, lester_petersen).
starring_as(the_horse_whisperer, john_hogarty, local_tracker).
starring_as(the_horse_whisperer, michel_lalonde, park_ranger).
starring_as(the_horse_whisperer, c_j_byrnes, doctor).
starring_as(the_horse_whisperer, kathy_baldwin_keenan, nurse_1).
starring_as(the_horse_whisperer, allison_moorer, barn_dance_vocalist).
starring_as(the_horse_whisperer, george_a_sack_jr, truck_driver).
starring_as(the_horse_whisperer, kellee_sweeney, nurse_2).
starring_as(the_horse_whisperer, stephen_pearlman, david_gottschalk).
starring_as(the_horse_whisperer, joelle_carter, office_worker_1).
starring_as(the_horse_whisperer, sunny_chae, office_worker_2).
starring_as(the_horse_whisperer, anne_joyce, office_worker_3).
starring_as(the_horse_whisperer, tara_sobeck, schoolgirl_1).
starring_as(the_horse_whisperer, kristy_ann_servidio, schoolgirl_2).
starring_as(the_horse_whisperer, marie_engle, neighbor).
starring_as(the_horse_whisperer, curt_pate, handsome_cowboy).
starring_as(the_horse_whisperer, steven_brian_conard, ranch_hand).
starring_as(the_horse_whisperer, tammy_pate, roper).
starring_as(the_horse_whisperer, gloria_lynne_henry, member_of_magazine_staff).
starring_as(the_horse_whisperer, lance_r_jones, ranch_hand).
starring_as(the_horse_whisperer, donnie_saylor, rugged_cowboy).
starring_as(the_horse_whisperer, george_strait, himself).

released(in_good_company, 2004).
directed(in_good_company, paul_weitz).
starring_as(in_good_company, dennis_quaid, dan_foreman).
starring_as(in_good_company, topher_grace, carter_duryea).
starring_as(in_good_company, scarlett_johansson, alex_foreman).
starring_as(in_good_company, marg_helgenberger, ann_foreman).
starring_as(in_good_company, david_paymer, morty).
starring_as(in_good_company, clark_gregg, mark_steckle).
starring_as(in_good_company, philip_baker_hall, eugene_kalb).
starring_as(in_good_company, selma_blair, kimberly).
starring_as(in_good_company, frankie_faison, corwin).
starring_as(in_good_company, ty_burrell, enrique_colon).
starring_as(in_good_company, kevin_chapman, lou).
starring_as(in_good_company, amy_aquino, alicia).
starring_as(in_good_company, zena_grey, jana_foreman).
starring_as(in_good_company, colleen_camp, receptionist).
starring_as(in_good_company, lauren_tom, obstetrician).
starring_as(in_good_company, ron_bottitta, porsche_dealer).
starring_as(in_good_company, jon_collin, waiter).
starring_as(in_good_company, shishir_kurup, maitre_d).
starring_as(in_good_company, tim_edward_rhoze, theo).
starring_as(in_good_company, enrique_castillo, hector).
starring_as(in_good_company, john_cho, petey).
starring_as(in_good_company, chris_ausnit, young_executive).
starring_as(in_good_company, francesca_roberts, loan_officer).
starring_as(in_good_company, gregory_north, lawyer).
starring_as(in_good_company, gregory_hinton, moving_man).
starring_as(in_good_company, todd_lyon, moving_man).
starring_as(in_good_company, thomas_j_dooley, moving_man).
starring_as(in_good_company, robin_t_kirksey, basketball_ringer).
starring_as(in_good_company, katherine_ellis, maya__roommate).
starring_as(in_good_company, nick_schutt, carter_s_assistant).
starring_as(in_good_company, john_kepley, salesman).
starring_as(in_good_company, mobin_khan, salesman).
starring_as(in_good_company, jeanne_kort, saleswoman).
starring_as(in_good_company, dean_a_parker, mike).
starring_as(in_good_company, richard_hotson, fired_employee).
starring_as(in_good_company, shar_washington, fired_employee).
starring_as(in_good_company, rebecca_hedrick, teddy_k_s_assistant).
starring_as(in_good_company, miguel_arteta, globecom_technician).
starring_as(in_good_company, sam_tippe, kid_at_party).
starring_as(in_good_company, roma_torre, anchorwoman).
starring_as(in_good_company, andre_cablayan, legally_dedd).
starring_as(in_good_company, dante_powell, legally_dedd).
starring_as(in_good_company, michalina_almindo, hector_s_date).
starring_as(in_good_company, bennett_andrews, greensman).
starring_as(in_good_company, claudia_barroso, bar_patron).
starring_as(in_good_company, jaclynn_tiffany_brown, basketball_player).
starring_as(in_good_company, malcolm_mcdowell, teddy_k__globecom_ceo).
starring_as(in_good_company, scott_sahadi, moving_man).
starring_as(in_good_company, loretta_shenosky, kalb_s_assistant).
starring_as(in_good_company, trevor_stynes, man_on_street).

released(just_cause, 1995).
directed(just_cause, arne_glimcher).
starring_as(just_cause, sean_connery, paul_armstrong).
starring_as(just_cause, laurence_fishburne, sheriff_tanny_brown).
starring_as(just_cause, kate_capshaw, laurie_armstrong).
starring_as(just_cause, blair_underwood, bobby_earl).
starring_as(just_cause, ed_harris, blair_sullivan).
starring_as(just_cause, christopher_murray, detective_t_j_wilcox).
starring_as(just_cause, ruby_dee, evangeline).
starring_as(just_cause, scarlett_johansson, kate_armstrong).
starring_as(just_cause, daniel_j_travanti, warden).
starring_as(just_cause, ned_beatty, mcnair).
starring_as(just_cause, liz_torres, delores_rodriguez).
starring_as(just_cause, lynne_thigpen, ida_conklin).
starring_as(just_cause, taral_hicks, lena_brown).
starring_as(just_cause, victor_slezak, sgt_rogers).
starring_as(just_cause, kevin_mccarthy, phil_prentiss).
starring_as(just_cause, hope_lange, libby_prentiss).
starring_as(just_cause, chris_sarandon, lyle_morgan).
starring_as(just_cause, george_plimpton, elder_phillips).
starring_as(just_cause, brooke_alderson, dr_doliveau).
starring_as(just_cause, colleen_fitzpatrick, prosecutor).
starring_as(just_cause, richard_liberty, chaplin).
starring_as(just_cause, joel_s_ehrenkranz, judge).
starring_as(just_cause, barbara_jean_kane, joanie_shriver).
starring_as(just_cause, maurice_jamaal_brown, reese_brown).
starring_as(just_cause, patrick_maycock, kid_washing_car_1).
starring_as(just_cause, jordan_f_vaughn, kid_washing_car_2).
starring_as(just_cause, francisco_paz, concierge).
starring_as(just_cause, marie_hyman, clerk).
starring_as(just_cause, s_bruce_wilson, party_guest).
starring_as(just_cause, erik_stephan, student).
starring_as(just_cause, melanie_hughes, receptionist).
starring_as(just_cause, megan_meinardus, slumber_party_girl).
starring_as(just_cause, melissa_hood_julien, slumber_party_girl).
starring_as(just_cause, jenna_del_buono, slumber_party_girl).
starring_as(just_cause, ashley_popelka, slumber_party_girl).
starring_as(just_cause, marisa_perry, slumber_party_girl).
starring_as(just_cause, ashley_council, slumber_party_girl).
starring_as(just_cause, augusta_lundsgaard, slumber_party_girl).
starring_as(just_cause, connie_lee_brown, prison_guard).
starring_as(just_cause, clarence_lark_iii, prison_guard).
starring_as(just_cause, monte_st_james, prisoner).
starring_as(just_cause, gary_landon_mills, prisoner).
starring_as(just_cause, shareef_malnik, prisoner).
starring_as(just_cause, tony_bolano, prisoner).
starring_as(just_cause, angelo_maldonado, prisoner).
starring_as(just_cause, fausto_rodriguez, prisoner).
starring_as(just_cause, karen_leeds, reporter).
starring_as(just_cause, dan_romero, reporter).
starring_as(just_cause, donn_lamkin, reporter).
starring_as(just_cause, stacie_a_zinn, reporter).
starring_as(just_cause, kylie_delre, woman_in_courtroom).
starring_as(just_cause, deborah_smith_ford, medical_examiner).
starring_as(just_cause, patrick_fullerton, reporter).
starring_as(just_cause, jody_millard, prison_guard).
starring_as(just_cause, michael_sassano, courtroom_observer).
starring_as(just_cause, rene_teboe, man_in_bus_terminal).

released(the_island, 2005).
directed(the_island, michael_bay).
starring_as(the_island, ewan_mcgregor, lincoln_six_echo_tom_lincoln).
starring_as(the_island, scarlett_johansson, jordan_two_delta_sarah_jordan).
starring_as(the_island, djimon_hounsou, albert_laurent).
starring_as(the_island, sean_bean, merrick).
starring_as(the_island, steve_buscemi, mccord).
starring_as(the_island, michael_clarke_duncan, starkweather).
starring_as(the_island, ethan_phillips, jones_three_echo).
starring_as(the_island, brian_stepanek, gandu_three_echo).
starring_as(the_island, noa_tishby, community_announcer).
starring_as(the_island, siobhan_flynn, lima_one_alpha).
starring_as(the_island, troy_blendell, laurent_team_member).
starring_as(the_island, jamie_mcbride, laurent_team_member).
starring_as(the_island, kevin_mccorkle, laurent_team_member).
starring_as(the_island, gary_nickens, laurent_team_member).
starring_as(the_island, kathleen_rose_perkins, laurent_team_member).
starring_as(the_island, richard_whiten, laurent_team_member).
starring_as(the_island, max_baker, carnes).
starring_as(the_island, phil_abrams, harvest_doctor).
starring_as(the_island, svetlana_efremova, harvest_midwife).
starring_as(the_island, katy_boyer, harvest_surgeon).
starring_as(the_island, randy_oglesby, harvest_surgeon).
starring_as(the_island, yvette_nicole_brown, harvest_nurse).
starring_as(the_island, taylor_gilbert, harvest_nurse).
starring_as(the_island, wendy_haines, harvest_nurse).
starring_as(the_island, tim_halligan, institute_coroner).
starring_as(the_island, glenn_morshower, medical_courier).
starring_as(the_island, michael_canavan, extraction_room_doctor).
starring_as(the_island, jimmy_smagula, extraction_room_technician).
starring_as(the_island, ben_tolpin, extraction_room_technician).
starring_as(the_island, robert_sherman, agnate_in_pod).
starring_as(the_island, rich_hutchman, dept_of_operations_supervisor).
starring_as(the_island, gonzalo_menendez, dept_of_operations_technician).
starring_as(the_island, olivia_tracey, dept_of_operations_agnate).
starring_as(the_island, ray_xifo, elevator_agnate).
starring_as(the_island, mary_pat_gleason, nutrition_clerk).
starring_as(the_island, ashley_yegan, stim_bar_bartender).
starring_as(the_island, whitney_dylan, client_services_operator).
starring_as(the_island, mitzi_martin, atrium_tour_guide).
starring_as(the_island, lewis_dauber, tour_group_man).
starring_as(the_island, shelby_leverington, tour_group_woman).
starring_as(the_island, don_creech, god_like_man).
starring_as(the_island, richard_v_licata, board_member).
starring_as(the_island, eamon_behrens, censor).
starring_as(the_island, alex_carter, censor).
starring_as(the_island, kevin_daniels, censor).
starring_as(the_island, grant_garrison, censor).
starring_as(the_island, kenneth_hughes, censor).
starring_as(the_island, brian_leckner, censor).
starring_as(the_island, dakota_mitchell, censor).
starring_as(the_island, marty_papazian, censor).
starring_as(the_island, phil_somerville, censor).
starring_as(the_island, ryan_tasz, censor).
starring_as(the_island, kirk_ward, censor).
starring_as(the_island, kelvin_han_yee, censor).
starring_as(the_island, shawnee_smith, suzie).
starring_as(the_island, chris_ellis, aces__spades_bartender).
starring_as(the_island, don_michael_paul, bar_guy).
starring_as(the_island, eric_stonestreet, ed_the_trucker).
starring_as(the_island, james_granoff, sarah_s_son).
starring_as(the_island, james_hart, lapd_officer).
starring_as(the_island, craig_reynolds, lapd_officer).
starring_as(the_island, trent_ford, calvin_klein_model).
starring_as(the_island, sage_thomas, girl_at_beach).
starring_as(the_island, mark_christopher_lawrence, construction_worker).
starring_as(the_island, jenae_altschwager, kim).
starring_as(the_island, john_anton, clone).
starring_as(the_island, mary_castro, busty_dancer_in_bar).
starring_as(the_island, kim_coates, charles_whitman).
starring_as(the_island, tom_everett, the_president).
starring_as(the_island, mitch_haubert, censor_doctor).
starring_as(the_island, robert_isaac, agnate).
starring_as(the_island, j_p_manoux, seven_foxtrot).
starring_as(the_island, jennifer_secord, patron).
starring_as(the_island, mckay_stewart, falling_building_dodger).
starring_as(the_island, skyler_stone, sarah_jordan_s_husband).
starring_as(the_island, richard_john_walters, agnate).

released(a_love_song_for_bobby_long, 2004).
directed(a_love_song_for_bobby_long, shainee_gabel).
starring_as(a_love_song_for_bobby_long, john_travolta, bobby_long).
starring_as(a_love_song_for_bobby_long, scarlett_johansson, pursy_will).
starring_as(a_love_song_for_bobby_long, gabriel_macht, lawson_pines).
starring_as(a_love_song_for_bobby_long, deborah_kara_unger, georgianna).
starring_as(a_love_song_for_bobby_long, dane_rhodes, cecil).
starring_as(a_love_song_for_bobby_long, david_jensen, junior).
starring_as(a_love_song_for_bobby_long, clayne_crawford, lee).
starring_as(a_love_song_for_bobby_long, sonny_shroyer, earl).
starring_as(a_love_song_for_bobby_long, walter_breaux, ray).
starring_as(a_love_song_for_bobby_long, carol_sutton, ruthie).
starring_as(a_love_song_for_bobby_long, warren_kole, sean).
starring_as(a_love_song_for_bobby_long, bernard_johnson, tiny).
starring_as(a_love_song_for_bobby_long, gina_ginger_bernal, waitress).
starring_as(a_love_song_for_bobby_long, douglas_m_griffin, man_1).
starring_as(a_love_song_for_bobby_long, earl_maddox, man_2).
starring_as(a_love_song_for_bobby_long, steve_maye, man_3).
starring_as(a_love_song_for_bobby_long, don_brady, old_man).
starring_as(a_love_song_for_bobby_long, will_barnett, old_man_2).
starring_as(a_love_song_for_bobby_long, patrick_mccullough, streetcar_boy).
starring_as(a_love_song_for_bobby_long, leanne_cochran, streetcar_girl).
starring_as(a_love_song_for_bobby_long, nick_loren, merchant).
starring_as(a_love_song_for_bobby_long, brooke_allen, sandy).
starring_as(a_love_song_for_bobby_long, sal_sapienza, jazz_club_patron).
starring_as(a_love_song_for_bobby_long, doc_whitney, alcoholic).

released(manny__lo, 1996).
directed(manny__lo, lisa_krueger).
starring_as(manny__lo, mary_kay_place, elaine).
starring_as(manny__lo, scarlett_johansson, amanda).
starring_as(manny__lo, aleksa_palladino, laurel).
starring_as(manny__lo, dean_silvers, suburban_family).
starring_as(manny__lo, marlen_hecht, suburban_family).
starring_as(manny__lo, forrest_silvers, suburban_family).
starring_as(manny__lo, tyler_silvers, suburban_family).
starring_as(manny__lo, lisa_campion, convenience_store_clerk).
starring_as(manny__lo, glenn_fitzgerald, joey).
starring_as(manny__lo, novella_nelson, georgine).
starring_as(manny__lo, susan_decker, baby_store_customer_1).
starring_as(manny__lo, marla_zuk, baby_store_customer_2).
starring_as(manny__lo, bonnie_johnson, baby_store_customer_3).
starring_as(manny__lo, melissa_johnson, child).
starring_as(manny__lo, angie_phillips, connie).
starring_as(manny__lo, cameron_boyd, chuck).
starring_as(manny__lo, monica_smith, chuck_s_mom).
starring_as(manny__lo, melanie_johansson, golf_course_family).
starring_as(manny__lo, karsten_johansson, golf_course_family).
starring_as(manny__lo, hunter_johansson, golf_course_family).
starring_as(manny__lo, vanessa_johansson, golf_course_family).
starring_as(manny__lo, frank_green_jr, other_golfer).
starring_as(manny__lo, shelley_dee_green, other_golfer).
starring_as(manny__lo, david_destaebler, golf_course_cop).
starring_as(manny__lo, mark_palmieri, golf_course_cop).
starring_as(manny__lo, paul_guilfoyle, country_house_owner).
starring_as(manny__lo, tony_arnaud, sheriff).
starring_as(manny__lo, nicholas_lent, lo_s_baby).

released(match_point, 2005).
directed(match_point, woody_allen).
starring_as(match_point, scarlett_johansson, nola_rice).
starring_as(match_point, jonathan_rhys_meyers, chris_wilton).
starring_as(match_point, emily_mortimer, chloe_hewett_wilton).
starring_as(match_point, matthew_goode, tom_hewett).
starring_as(match_point, brian_cox, alec_hewett).
starring_as(match_point, penelope_wilton, eleanor_hewett).
starring_as(match_point, layke_anderson, youth_at_palace_theatre).
starring_as(match_point, alexander_armstrong, '').
starring_as(match_point, morne_botes, michael).
starring_as(match_point, rose_keegan, carol).
starring_as(match_point, eddie_marsan, reeves).
starring_as(match_point, james_nesbitt, '').
starring_as(match_point, steve_pemberton, di_parry).
starring_as(match_point, miranda_raison, heather).
starring_as(match_point, colin_salmon, '').
starring_as(match_point, zoe_telford, samantha).

released(my_brother_the_pig, 1999).
directed(my_brother_the_pig, erik_fleming).
starring_as(my_brother_the_pig, nick_fuoco, george_caldwell).
starring_as(my_brother_the_pig, scarlett_johansson, kathy_caldwell).
starring_as(my_brother_the_pig, judge_reinhold, richard_caldwell).
starring_as(my_brother_the_pig, romy_windsor, dee_dee_caldwell).
starring_as(my_brother_the_pig, eva_mendes, matilda).
starring_as(my_brother_the_pig, alex_d_linz, freud).
starring_as(my_brother_the_pig, paul_renteria, border_guard).
starring_as(my_brother_the_pig, renee_victor, grandma_berta).
starring_as(my_brother_the_pig, cambria_gonzalez, mercedes).
starring_as(my_brother_the_pig, nicole_zarate, annie).
starring_as(my_brother_the_pig, eduardo_antonio_garcia, luis).
starring_as(my_brother_the_pig, siri_baruc, tourist_girl).
starring_as(my_brother_the_pig, charlie_combes, tourist_dad).
starring_as(my_brother_the_pig, dee_ann_johnston, tourist_mom).
starring_as(my_brother_the_pig, marco_rodriguez, eduardo).
starring_as(my_brother_the_pig, rob_johnston, taxi_driver).
starring_as(my_brother_the_pig, dee_bradley_baker, pig_george).

released(north, 1994).
directed(north, rob_reiner).
starring_as(north, elijah_wood, north).
starring_as(north, jason_alexander, north_s_dad).
starring_as(north, julia_louis_dreyfus, north_s_mom).
starring_as(north, marc_shaiman, piano_player).
starring_as(north, jussie_smollett, adam).
starring_as(north, taylor_fry, zoe).
starring_as(north, alana_austin, sarah).
starring_as(north, peg_shirley, teacher).
starring_as(north, chuck_cooper, umpire).
starring_as(north, alan_zweibel, coach).
starring_as(north, donavon_dietz, assistant_coach).
starring_as(north, teddy_bergman, teammate).
starring_as(north, michael_cipriani, teammate).
starring_as(north, joran_corneal, teammate).
starring_as(north, joshua_kaplan, teammate).
starring_as(north, bruce_willis, narrator).
starring_as(north, james_f_dean, dad_smith).
starring_as(north, glenn_walker_harris_jr, jeffrey_smith).
starring_as(north, nancy_nichols, mom_jones).
starring_as(north, ryan_o_neill, andy_wilson).
starring_as(north, kim_delgado, dad_johnson).
starring_as(north, tony_t_johnson, steve_johnson).
starring_as(north, matthew_mccurley, winchell).
starring_as(north, carmela_rappazzo, receptionist).
starring_as(north, jordan_jacobson, vice_president).
starring_as(north, rafale_yermazyan, austrian_dancer).
starring_as(north, jon_lovitz, arthur_belt).
starring_as(north, mitchell_group, dad_wilson).
starring_as(north, pamela_harley, reporter).
starring_as(north, glenn_kubota, reporter).
starring_as(north, matthew_arkin, reporter).
starring_as(north, marc_coppola, reporter).
starring_as(north, colette_bryce, reporter).
starring_as(north, bryon_stewart, bailiff).
starring_as(north, alan_arkin, judge_buckle).
starring_as(north, alan_rachins, defense_attorney).
starring_as(north, abbe_levin, operator).
starring_as(north, lola_pashalinski, operator).
starring_as(north, kimberly_topper, operator).
starring_as(north, c_c_loveheart, operator).
starring_as(north, helen_hanft, operator).
starring_as(north, carol_honda, operator).
starring_as(north, peggy_gormley, operator).
starring_as(north, lillias_white, operator).
starring_as(north, dan_aykroyd, pa_tex).
starring_as(north, reba_mcentire, ma_tex).
starring_as(north, mark_meismer, texas_dancer).
starring_as(north, danielle_burgio, texas_dancer).
starring_as(north, bryan_anthony, texas_dancer).
starring_as(north, carmit_bachar, texas_dancer).
starring_as(north, james_harkness, texas_dancer).
starring_as(north, krista_buonauro, texas_dancer).
starring_as(north, brett_heine, texas_dancer).
starring_as(north, kelly_cooper, texas_dancer).
starring_as(north, chad_e_allen, texas_dancer).
starring_as(north, stefanie_roos, texas_dancer).
starring_as(north, donovan_keith_hesser, texas_dancer).
starring_as(north, jenifer_strovas, texas_dancer).
starring_as(north, christopher_d_childers, texas_dancer).
starring_as(north, sebastian_lacause, texas_dancer).
starring_as(north, lydia_e_merritt, texas_dancer).
starring_as(north, greg_rosatti, texas_dancer).
starring_as(north, kelly_shenefiel, texas_dancer).
starring_as(north, jenifer_panton, betty_lou).
starring_as(north, keone_young, governor_ho).
starring_as(north, lauren_tom, mrs_ho).
starring_as(north, gil_janklowicz, man_on_beach).
starring_as(north, maud_winchester, stewart_s_mom).
starring_as(north, tyler_gurciullo, stewart).
starring_as(north, fritz_sperberg, stewart_s_dad).
starring_as(north, brynn_hartman, waitress).
starring_as(north, larry_b_williams, alaskan_pilot).
starring_as(north, graham_greene, alaskan_dad).
starring_as(north, kathy_bates, alaskan_mom).
starring_as(north, abe_vigoda, alaskan_grandpa).
starring_as(north, richard_belzer, barker).
starring_as(north, monty_bass, eskimo).
starring_as(north, farrell_thomas, eskimo).
starring_as(north, billy_daydoge, eskimo).
starring_as(north, henri_towers, eskimo).
starring_as(north, caroline_carr, eskimo).
starring_as(north, eva_larson, eskimo).
starring_as(north, ben_stein, curator).
starring_as(north, marla_frees, d_c_reporter).
starring_as(north, robert_rigamonti, d_c_reporter).
starring_as(north, alexander_godunov, amish_dad).
starring_as(north, kelly_mcgillis, amish_mom).
starring_as(north, jay_black, amish_pilot).
starring_as(north, rosalind_chao, chinese_mom).
starring_as(north, george_cheung, chinese_barber).
starring_as(north, ayo_adejugbe, african_dad).
starring_as(north, darwyn_carson, african_mom).
starring_as(north, lucy_lin, female_newscaster).
starring_as(north, faith_ford, donna_nelson).
starring_as(north, john_ritter, ward_nelson).
starring_as(north, scarlett_johansson, laura_nelson).
starring_as(north, jesse_zeigler, bud_nelson).
starring_as(north, robert_costanzo, al).
starring_as(north, audrey_klebahn, secretary).
starring_as(north, philip_levy, panhandler).
starring_as(north, dan_grimaldi, hot_dog_vendor).
starring_as(north, marvin_braverman, waiter).
starring_as(north, wendle_josepher, ticket_agent).
starring_as(north, adam_zweibel, kid_in_airport).
starring_as(north, matthew_horn, kid_in_airport).
starring_as(north, sarah_martineck, kid_in_airport).
starring_as(north, brian_levinson, kid_in_airport).
starring_as(north, d_l_shroder, federal_express_agent).
starring_as(north, brother_douglas, new_york_city_pimp).
starring_as(north, nick_taylor, newsman).
starring_as(north, jim_great_elk_waters, eskimo_father).
starring_as(north, michael_werckle, amish_boy).

released(the_perfect_score, 2004).
directed(the_perfect_score, brian_robbins).
starring_as(the_perfect_score, erika_christensen, anna_ross).
starring_as(the_perfect_score, chris_evans, kyle).
starring_as(the_perfect_score, bryan_greenberg, matty_matthews).
starring_as(the_perfect_score, scarlett_johansson, francesca_curtis).
starring_as(the_perfect_score, darius_miles, desmond_rhodes).
starring_as(the_perfect_score, leonardo_nam, roy).
starring_as(the_perfect_score, tyra_ferrell, desmond_s_mother).
starring_as(the_perfect_score, matthew_lillard, larry).
starring_as(the_perfect_score, vanessa_angel, anita_donlee).
starring_as(the_perfect_score, bill_mackenzie, lobby_guard).
starring_as(the_perfect_score, dan_zukovic, mr_g).
starring_as(the_perfect_score, iris_quinn, kyle_s_mother).
starring_as(the_perfect_score, lorena_gale, proctor).
starring_as(the_perfect_score, patricia_idlette, receptionist).
starring_as(the_perfect_score, lynda_boyd, anna_s_mother).
starring_as(the_perfect_score, michael_ryan, anna_s_father).
starring_as(the_perfect_score, robert_clarke, arnie_branch).
starring_as(the_perfect_score, serge_houde, kurt_dooling).
starring_as(the_perfect_score, kyle_labine, dave).
starring_as(the_perfect_score, dee_jay_jackson, ets_lobby_guard).
starring_as(the_perfect_score, alf_humphreys, tom_helton).
starring_as(the_perfect_score, fulvio_cecere, francesca_s_father).
starring_as(the_perfect_score, mike_jarvis, illinois_coach).
starring_as(the_perfect_score, steve_makaj, kyle_s_father).
starring_as(the_perfect_score, kurt_max_runte, swat_captain).
starring_as(the_perfect_score, jay_brazeau, test_instructor).
starring_as(the_perfect_score, rebecca_reichert, tiffany).
starring_as(the_perfect_score, jessica_may, ets_woman).
starring_as(the_perfect_score, miriam_smith, ets_reception).
starring_as(the_perfect_score, alex_green, security_guard).
starring_as(the_perfect_score, samuel_scantlebury, keyon).
starring_as(the_perfect_score, sonja_bennett, pregnant_girl).
starring_as(the_perfect_score, sarah_afful, girl).
starring_as(the_perfect_score, alex_corr, preppy_boy).
starring_as(the_perfect_score, nikolas_malenovic, boy).
starring_as(the_perfect_score, john_shaw, ets_man).
starring_as(the_perfect_score, jamie_yochlowitz, man_in_jail).
starring_as(the_perfect_score, rob_boyce, guard).
starring_as(the_perfect_score, paul_campbell, guy_in_truck).

released(the_spongebob_squarepants_released, 2004).
directed(the_spongebob_squarepants_released, stephen_hillenburg).
starring_as(the_spongebob_squarepants_released, tom_kenny, spongebob_narrator_gary_clay_tough_fish_2_twin_2_houston_voice).
starring_as(the_spongebob_squarepants_released, clancy_brown, mr_krabs).
starring_as(the_spongebob_squarepants_released, rodger_bumpass, squidward_fish_4).
starring_as(the_spongebob_squarepants_released, bill_fagerbakke, patrick_star_fish_2_chum_customer_local_fish).
starring_as(the_spongebob_squarepants_released, mr_lawrence, plankton_fish_7_attendant_2_lloyd).
starring_as(the_spongebob_squarepants_released, jill_talley, karen_the_computer_wife_old_lady).
starring_as(the_spongebob_squarepants_released, carolyn_lawrence, sandy).
starring_as(the_spongebob_squarepants_released, mary_jo_catlett, mrs_puff).
starring_as(the_spongebob_squarepants_released, jeffrey_tambor, king_neptune).
starring_as(the_spongebob_squarepants_released, scarlett_johansson, mindy).
starring_as(the_spongebob_squarepants_released, alec_baldwin, dennis).
starring_as(the_spongebob_squarepants_released, david_hasselhoff, himself).
starring_as(the_spongebob_squarepants_released, kristopher_logan, squinty_the_pirate).
starring_as(the_spongebob_squarepants_released, d_p_fitzgerald, bonesy_the_pirate).
starring_as(the_spongebob_squarepants_released, cole_s_mckay, scruffy_the_pirate).
starring_as(the_spongebob_squarepants_released, dylan_haggerty, stitches_the_pirate).
starring_as(the_spongebob_squarepants_released, bart_mccarthy, captain_bart_the_pirate).
starring_as(the_spongebob_squarepants_released, henry_kingi, inky_the_pirate).
starring_as(the_spongebob_squarepants_released, randolph_jones, tiny_the_pirate).
starring_as(the_spongebob_squarepants_released, paul_zies, upper_deck_the_pirate).
starring_as(the_spongebob_squarepants_released, gerard_griesbaum, fingers_the_pirate).
starring_as(the_spongebob_squarepants_released, aaron_hendry, tangles_the_pirate_cyclops_diver).
starring_as(the_spongebob_squarepants_released, maxie_j_santillan_jr, gummy_the_pirate).
starring_as(the_spongebob_squarepants_released, peter_deyoung, leatherbeard_the_pirate).
starring_as(the_spongebob_squarepants_released, gino_montesinos, tango_the_pirate).
starring_as(the_spongebob_squarepants_released, john_siciliano, pokey_the_pirate).
starring_as(the_spongebob_squarepants_released, david_stifel, cookie_the_pirate).
starring_as(the_spongebob_squarepants_released, alex_baker, martin_the_pirate).
starring_as(the_spongebob_squarepants_released, robin_russell, sniffy_the_pirate).
starring_as(the_spongebob_squarepants_released, tommy_schooler, salty_the_pirate).
starring_as(the_spongebob_squarepants_released, ben_wilson, stovepipe_the_pirate).
starring_as(the_spongebob_squarepants_released, jose_zelaya, dooby_the_pirate).
starring_as(the_spongebob_squarepants_released, mageina_tovah, usher).
starring_as(the_spongebob_squarepants_released, chris_cummins, concession_guy).
starring_as(the_spongebob_squarepants_released, todd_duffey, concession_guy).
starring_as(the_spongebob_squarepants_released, dee_bradley_baker, man_cop_phil_perch_perkins_waiter_attendant_1_thug_1_coughing_fish_twin_1_frog_fish_monster_freed_fish_sandals).
starring_as(the_spongebob_squarepants_released, sirena_irwin, reporter_driver_ice_cream_lady).
starring_as(the_spongebob_squarepants_released, lori_alan, pearl).
starring_as(the_spongebob_squarepants_released, thomas_f_wilson, fish_3_tough_fish_1_victor).
starring_as(the_spongebob_squarepants_released, carlos_alazraqui, squire_goofy_goober_announcer_thief).
starring_as(the_spongebob_squarepants_released, joshua_seth, prisoner).
starring_as(the_spongebob_squarepants_released, tim_blaney, singing_goofy_goober).
starring_as(the_spongebob_squarepants_released, derek_drymon, the_screamer_fisherman).
starring_as(the_spongebob_squarepants_released, aaron_springer, laughing_bubble).
starring_as(the_spongebob_squarepants_released, neil_ross, cyclops).
starring_as(the_spongebob_squarepants_released, stephen_hillenburg, parrot).
starring_as(the_spongebob_squarepants_released, michael_patrick_bell, fisherman).
starring_as(the_spongebob_squarepants_released, jim_wise, goofy_goober_rock_singer).

released(untitled_woody_allen_fall_project_2006, 2006).
directed(untitled_woody_allen_fall_project_2006, woody_allen).
starring_as(untitled_woody_allen_fall_project_2006, woody_allen, '').
starring_as(untitled_woody_allen_fall_project_2006, jody_halse, bouncer).
starring_as(untitled_woody_allen_fall_project_2006, hugh_jackman, '').
starring_as(untitled_woody_allen_fall_project_2006, scarlett_johansson, '').
starring_as(untitled_woody_allen_fall_project_2006, robyn_kerr, '').
starring_as(untitled_woody_allen_fall_project_2006, kevin_mcnally, mike_tinsley).
starring_as(untitled_woody_allen_fall_project_2006, ian_mcshane, '').
starring_as(untitled_woody_allen_fall_project_2006, james_nesbitt, '').
starring_as(untitled_woody_allen_fall_project_2006, colin_salmon, '').

released(a_view_from_the_bridge, 2006).
starring_as(a_view_from_the_bridge, scarlett_johansson, catherine).
starring_as(a_view_from_the_bridge, anthony_lapaglia, eddie_carbone).


