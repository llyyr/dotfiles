" Keywords
syn keyword gcsimKeyword let while if else fn switch case default break continue fallthrough return for
syn keyword gcsimKeyword options add char stats weapon set lvl refine cons talent count active target particle_threshold particle_drop_count resist energy hurt radius pos rand

" Abilities
syn keyword gcsimAbility attack charge aim skill burst low_plunge high_plunge dash jump walk swap

" Stats
syn match gcsimStat "\<\(hp%\?\|atk%\?\|def%\?\|er\|em\|cr\|cd\|heal\|phys%\|electro%\?\|pyro%\?\|dendro%\?\|hydro%\?\|geo%\?\|anemo%\?\|cryo%\?\)\>"

" Options
syn keyword gcsimOption iteration duration swap_delay workers hitlag defhalt ignore_burst_energy

" Miscellaneous
syn match gcsimElement "\<\(interval\|every\|once\|amount\|element\|resist\|physical\|start_hp%\?\|start_energy\|freeze_resist\)\>"

" Avatars
syn keyword gcsimAvatar traveleranemo travelergeo travelerelectro travelerdendro travelerhydro travelerpyro travelercryo aether-anemo lumine-anemo aether-geo lumine-geo aether-electro lumine-electro aether-dendro lumine-dendro aether-hydro lumine-hydro aether-pyro lumine-pyro aether-cryo lumine-cryo aetheranemo lumineanemo aethergeo luminegeo aetherelectro lumineelectro aetherdendro luminedendro aetherhydro luminehydro aetherpyro luminepyro aethercryo luminecryo albedo aloy amber barbara barb beidou bennett charlotte chongyun chong cyno diluc diona eula fischl fish amy ganyu hutao tao ht jean kaedeharakazuha kazuha kaz kaeya kamisatoayaka ayaka kamisatoayato ayato keqing keq klee kujousara kujosara sara lisa mona ningguang ning noelle qiqi raidenshogun raiden herexcellencythealmightynarukamiogoshogodofthunder razor rosaria rosa sangonomiyakokomi kokomi koko sayu sucrose tartaglia childe thoma venti xiangling xl xianyun cloudretainer liuyun xiao xingqiu xq xinyan yanfei yoimiya yoi yunjin zhongli zhong zl gorou aratakiitto itto aratakitheoneandoniitto shenhe yae yaemiko yelan kukishinobu kuki shikanoinheizou heizou tighnari collei dori candace nilou kusanali lesserlordkusanali nahida layla faruzan faru wanderer scaramouche scara kunikuzushi kuni kabukimono alhaitham haitham baizhu dehya yaoyao mika kaveh kirara lyney lynette neuvillette neuv chiefjusticeoffontaine freminet furina furinadefontaine navia demoiselle wriothesley wrio chevreuse chev gaming chiori arlecchino arle clorinde emilie mualani sethos xilonen xilo

" Numbers
syn match gcsimNumber "\<\d\+\>"

" Strings
syn region gcsimString start=/""/ end=/""/

" Comments
syn match gcsimComment "#.*$" contains=@Spell

" Highlight groups
hi def link gcsimKeyword Keyword
hi def link gcsimAbility Function
hi def link gcsimStat Type
hi def link gcsimOption StorageClass
hi def link gcsimElement Identifier
hi def link gcsimAvatar Constant
hi def link gcsimNumber Number
hi def link gcsimString String
hi def link gcsimComment Comment

let b:current_syntax = "gcsim"
