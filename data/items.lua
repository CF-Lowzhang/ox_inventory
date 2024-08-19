return {
        ----------------------------------------------------------------
        -- Basic Item
        ----------------------------------------------------------------
        ['notepad'] = {
            label = '筆記本',--'筆記本',
            weight = 100,
            stack = 1,
            close = 1,
            consume = 0,
            client = {
            }
        },
        ['notepage'] = {
            label = '筆記(Dev)',--'筆記本',
            weight = 1,
            stack = 0,
            close = 1,
            consume = 0,
            client = {
            }
        },
        ["money"] = {
            label = "紙錢",
            weight = 0,
            stack = true,
            close = true,
            description = "合法之錢幣"
        },
        ['bpclothing'] = {
            label = '衣服背包', --'衣服'
            consume = 0
        },
        ["phone"] = {
            label = "手機",
            weight = 100,
            stack = true,
            close = true,
        },
        ["radio"] = {
            label = "無線電",
            weight = 100,
            stack = false,
            close = true,
            client = {
                event = 'CF_Radio:openRadio',
                remove = function(total)
                    if total < 1 then
                        print(total)
                        TriggerEvent('we_radio:disableRadio')
                    end
                end
            }
        },
        ['acar_keys'] = {
            label = '萬能車鑰匙',--'萬能車鑰匙',
            weight = 200,
            stack = true,
            close = true,
            client = {}
        }, 
        ['car_keys'] = {
            label = '車鑰匙',--'車鑰匙',
            weight = 200,
            stack = false,
            close = true,
            client = {
                event = 'CF_VehicleKey:LockUnlock'
            }
        },
        ["umbrella"] = {
            label = "摺疊雨傘",
            weight = 212,
            stack = false,
            close = true,
        },
        ["poster"] = {
            label = "海報",
            weight = 3,
            stack = 1,
            close = true,
        },
        ----------------------------------------------------------------
        -- JDZ1 Item
        ----------------------------------------------------------------
        
        ['jdz1_blue_heart'] = {
            label = '藍色愛心小卡',weight = 5,stack = true,close = true,consume = 0,
            description = '卡片下面的小字上寫著：「交給女僕會有好事發生！」',
        },
        ['jdz1_red_heart'] = {
            label = '紅色愛心小卡',weight = 5,stack = true,close = true,consume = 0,
            description = '卡片下面的小字上寫著：「交給執事會有好事發生！」',
        },
        ['jdz1_dogtag'] = {
            label = '金屬掛牌',weight = 20,stack = true,close = true,consume = 0,
            description = '雖然是金屬製卻未見鏽蝕，可以清楚看見鐵牌上面刻著「い」。',
        },
        ['jdz1_maple'] = {
            label = '乾燥楓葉',weight = 5,stack = true,close = true,consume = 0,
            description = '樹葉上隱約有張臉，看不清是什麼樣貌。',
        },
        ['jdz1_parchment'] = {
            label = '完好的羊皮紙',weight = 20,stack = true,close = true,consume = 0,
            description = '看的出來是張新的羊皮紙，正中央貼著圖樣的影本，背面似乎有什麼字。',
        },
        ['jdz1_parchmentmap'] = {
            label = '些微破損的羊皮地圖',weight = 20,stack = true,close = true,consume = 0,
            description = '使用頻繁的羊皮地圖，背面似乎有什麼字',
        },
        ['jdz1_spatula'] = {
            label = '鍋鏟',weight = 50,stack = true,close = true,consume = 0,
            description = '採集用鍋鏟',
        },
        ['jdz1_moon'] = {
            label = '月鈴花',weight = 10,stack = true,close = true,consume = 0,
            description = '似乎可以聽到些許的呢喃...錯覺吧?',
        },
        ['jdz1_belg'] = {
            label = '比利時夾心巧克力',weight = 250,stack = true,close = true,consume = 0,
            description = '美麗的巧克力',
        },
        ['jdz1_choco'] = {
            label = '巧克力千層酥',weight = 160,stack = true,close = true,consume = 0,
            description = '酥酥脆脆的巧克力酥',
        },
        ['jdz1_star'] = {
            label = '仰望星空派',weight = 250,stack = true,close = true,consume = 0,
            description = '似乎有甚麼視線注視著你...應該是...錯覺吧？',
        },
        ['jdz1_cake'] = {
            label = '法式草莓夾心蛋糕',weight = 160,stack = true,close = true,consume = 0,
            description = '散發著草莓香味的蛋糕',
        },
        ['jdz1_cigar'] = {
            label = '法式雪茄捲',weight = 100,stack = true,close = true,consume = 0,
            description = '香香甜甜的長條型餅乾',
        },
        ['jdz1_rosecookie'] = {
            label = '玫瑰餅乾',weight = 45,stack = true,close = true,consume = 0,
            description = '隱含著淡淡玫瑰花香的餅乾',
        },
        ['jdz1_vanil'] = {
            label = '香草',weight = 20,stack = true,close = true,consume = 0,
            description = '',
        },
        ['jdz1_tool'] = {
            label = '採集道具大禮包',weight = 2000,stack = true,close = true,consume = 0,
            description = '一個有點沉重的包裹',
        },
        ['jdz10008-1'] = {
            label = '手串藍貝殼項鍊',weight = 50,stack = true,close = true,consume = 0,
            description = '翻到項鍊背面有用星沙排成的愛心形狀',
        },
        ['jdz1_msg'] = {
            label = '瓶中信',weight = 10,stack = true,close = true,consume = 0,
            description = '裡面好像塞著一張紙',
        },
        ['jdz1_demon'] = {
            label = '惡魔之書',weight = 150,stack = true,close = true,consume = 0,
            description = '封面很可怕的書，但好像也就這樣而已?',
        },
        ['jdz1_srecipet'] = {
            label = '神秘的料理食譜',weight = 10,stack = true,close = true,consume = 0,
            description = '上面寫著一道料理的方法',
        },
        ['jdz1_recipet'] = {
            label = '食譜',weight = 10,stack = true,close = true,consume = 0,
            description = '上面寫著料理的方法',
        },
        ['jdz1_label'] = {
            label = '名牌',weight = 10,stack = true,close = true,consume = 0,
            description = '上面寫著你的名字',
        },
        ['jdz1_medpk'] = {
            label = '愛心醫療包',weight = 200,stack = true,close = true,consume = 1,
            description = '心型的醫療包',
        },
        ['jdz1_ticket'] = {
            label = '船票',weight = 10,stack = true,close = true,consume = 0,
            description = '一張高級船票',
        },
        ['jdz1_ring'] = {
            label = '戒指',weight = 10,stack = true,close = true,consume = 0,
            description = '一枚高級的戒指',
        },
        ['jdz1_efood'] = {
            label = '某組織緊急口糧',weight = 250,stack = true,close = true,consume = 1,
            description = '某組織緊急口糧',
            client = {
                status = {hunger = 220000, thirst = -120000},
                anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
                prop = {
                    model = "prop_cs_burger_01",
                    pos = {x = 0.02, y = 0.02, z = -0.02},
                    rot = {x = 0.0, y = 0.0, z = 0.0}
                },
                usetime = 2500,
                notification = "雖然很飽，但是口乾舌燥。"
            }
        },
        ['jdz1_ssand'] = {
            label = '星砂',weight = 1,stack = true,close = true,consume = 0,
            description = '星型顆粒的砂狀海洋堆積物。',
        },
        ['jdz1_bttle'] = {
            label = '星砂瓶',weight = 8,stack = true,close = true,consume = 0,
            description = '小小的玻璃瓶裡面裝著星砂，在光線下閃閃發亮。',
        },
        ['jdz1_card'] = {label = '女僕卡包',weight = 5,stack = true,close = true,consume = 1,description = '女僕卡包',},
        ['jdz1_card1'] = {label = '女僕卡',weight = 5,stack = true,close = true,consume = 0,description = '女僕卡',},
        ['jdz1_card2'] = {label = '女僕卡',weight = 5,stack = true,close = true,consume = 0,description = '女僕卡',},
        ['jdz1_card3'] = {label = '女僕卡',weight = 5,stack = true,close = true,consume = 0,description = '女僕卡',},
        ['jdz1_card4'] = {label = '女僕卡',weight = 5,stack = true,close = true,consume = 0,description = '女僕卡',},
        ['jdz1_card5'] = {label = '女僕卡',weight = 5,stack = true,close = true,consume = 0,description = '女僕卡',},
        ['jdz1_card6'] = {label = '女僕卡',weight = 5,stack = true,close = true,consume = 0,description = '女僕卡',},
        ['jdz1_card7'] = {label = '女僕卡',weight = 5,stack = true,close = true,consume = 0,description = '女僕卡',},
        
        ['jdz10011-1']  = {label = '蕎麥麵',weight = 250,stack = false,close = true,consume = 1,description = '醬油、鮮味在碗裡融在一起，請搭配開水一起喝，適當洗刷口中的味道，再次品嘗海鮮的味道',client = {status = {hunger = 250000},anim = "eating",usetime = 2500}},
        ['jdz10011-2']  = {label = '鮭魚',weight = 200,stack = true,close = true,consume = 0,description = '不可直接食用，不知名的人養殖的',},
        ['jdz10011-3']  = {label = '鰹魚',weight = 150,stack = true,close = true,consume = 0,description = '不可直接食用，不知名的人養殖的',},
        ['jdz10011-4']  = {label = '鱒魚',weight = 150,stack = true,close = true,consume = 0,description = '不可直接食用，不知名的人養殖的',},
        ['jdz10011-5']  = {label = '蝦',weight = 90,stack = true,close = true,consume = 0,description = '不可直接食用，不知名的人養殖的',},
        ['jdz10011-6']  = {label = '魷',weight = 100,stack = true,close = true,consume = 0,description = '不可直接食用，不知名的人養殖的',},
        ['jdz10011-7']  = {label = '鰻',weight = 200,stack = true,close = true,consume = 0,description = '不可直接食用，不知名的人養殖的',},
        ['jdz10011-8']  = {label = '蛸',weight = 90,stack = true,close = true,consume = 0,description = '不可直接食用，不知名的人養殖的',},
        ['jdz10011-9']  = {label = '鰤',weight = 100,stack = true,close = true,consume = 0,description = '不可直接食用，不知名的人養殖的',},
        ['jdz10011-10'] = {label = '鱚',weight = 20,stack = true,close = true,consume = 0,description = '不可直接食用，不知名的人養殖的，通常用作當餌',},
        ['jdz10011-11'] = {label = '麵糰',weight = 100,stack = true,close = true,consume = 0,description = '不可直接食用，通常用來作麵食',},
        ['jdz10011-12'] = {label = '鯛',weight = 100,stack = true,close = true,consume = 0,description = '不可直接食用，不知名的人養殖的',},
        ['jdz10011-13'] = {label = '甜味玉子燒',weight = 90,stack = false,close = true,consume = 1,description = '用雞蛋和白糖做成的玉子燒，蛋香濃郁，吃起來帶點甜味 ', client = {status = {hunger =  90000},anim = "eating",usetime = 900}},
        ['jdz10011-14'] = {label = '魚肉玉子燒',weight = 120,stack = false,close = true,consume = 1,description = '用雞蛋和魚肉做成的玉子燒，蛋香濃郁，吃起來帶點醬油味與海味，魚肉扎實的口感讓人感到飽足。',client = {status = {hunger = 120000},anim = "eating",usetime = 1200}},
        ['jdz10011-15'] = {label = '蛋',weight = 30,stack = true,close = true,consume = 0,description = '雞蛋，蛋白質！好吃又營養！',},
        ['jdz10011-16'] = {label = '唐揚雞',weight = 250,stack = false,close = true,consume = 1,description = '外酥里嫩的唐揚雞，金黃香脆，嫩滑多汁，每一口都充滿濃郁風味。',client = {status = {hunger = 250000},anim = "eating",usetime = 2500}},
        ['jdz10011-17'] = {label = '漢堡排',weight = 150,stack = false,close = true,consume = 1,description = '多汁嫩滑的漢堡排，口感扎實，風味濃郁。',client = {status = {hunger = 150000},anim = "eating",usetime = 1500}},
        ['jdz10011-18'] = {label = '親子丼',weight = 250,stack = false,close = true,consume = 1,description = '鮮嫩雞肉配上滑蛋和香甜醬汁，溫暖人心。',client = {status = {hunger = 250000},anim = "eating",usetime = 2500}},
        ['jdz10011-19'] = {label = '酪梨',weight = 100,stack = false,close = true,consume = 1,description = '果肉柔滑如奶油，味道清新淡雅，富含營養，可以生吃。',client = {status = {hunger = 20000},anim = "eating",usetime = 1000}},
        ['jdz10011-20'] = {label = '酪梨白蝦沙拉',weight = 200,stack = false,close = true,consume = 1,description = '白蝦與酪梨結合在一起，搭配和風醬清爽又營養。',client = {status = {hunger = 150000},anim = "eating",usetime = 2000}},
        ['jdz10011-21'] = {label = '大鳳大吟釀',weight = 400,stack = false,close = true,consume = 1,description = '酒體豐滿醇厚，入口綿滑，散發著濃郁的米香與果香，餘味悠長。',client = {status = {drunk = 300000},anim = "drinking",usetime = 3000}},
        ['jdz10011-22'] = {label = '鹿谷本吟釀',weight = 400,stack = false,close = true,consume = 1,description = '酒體清澈，口感純淨爽口，帶有淡淡的米香，回味甘醇，清新宜人。',client = {status = {drunk = 300000},anim = "drinking",usetime = 3000}},
        ['jdz10011-23'] = {label = '高虎吟釀',weight = 400,stack = false,close = true,consume = 1,description = '口感細膩柔和，酒體輕盈，散發出優雅的花果香氣，餘味清爽，令人回味無窮。',client = {status = {drunk = 300000},anim = "drinking",usetime = 3000}},
        ['jdz10011-24'] = {label = '蛸梅',weight = 400,stack = false,close = true,consume = 1,description = '酒體晶透，入口甘甜微酸，散發濃郁的梅子香氣，口感圓潤，餘味清新怡人。',client = {status = {drunk = 300000},anim = "drinking",usetime = 3000}},
        ['jdz10011-25'] = {label = '蛸梅',weight = 400,stack = false,close = true,consume = 1,description = '酒體晶透，入口甘甜微酸，散發濃郁的梅子香氣，口感圓潤，餘味清新怡人。',client = {status = {drunk = 300000},anim = "drinking",usetime = 3000}},
     
        ----------------------------------------------------------------
        -- Animal Item
        ----------------------------------------------------------------

        ["animal-flute"] = {
            label = "獸笛",
            weight = 60,
            stack = 0,
            close = true,
        },
        ["animal-flute_deer"] = {
            label = "獸笛(鹿)",
            weight = 60,
            stack = 0,
            close = true,
        },
        ["animal-flute_horse"] = {
            label = "獸笛(馬)",
            weight = 60,
            stack = 0,
            close = true,
        },
        ["animal-flute_boar"] = {
            label = "獸笛(豬)",
            weight = 60,
            stack = 0,
            close = true,
        },
        ["animal-flute_lion"] = {
            label = "獸笛(山獅)",
            weight = 60,
            stack = 0,
            close = true,
        },
        ["animal-flute_cow"] = {
            label = "獸笛(牛)",
            weight = 60,
            stack = 0,
            close = true,
        },



        ----------------------------------------------------------------
        -- Props Item
        ----------------------------------------------------------------

        ["p_cone"] = {
            label = "三角錐",
            weight = 211,
            stack = 0,
            close = true,
        },
        ["p_barrier"] = {
            label = "路障",
            weight = 1200,
            stack = 0,
            close = true,
        },
        ["p_barrier2"] = {
            label = "路障",
            weight = 1200,
            stack = 0,
            close = true,
        },
        ----------------------------------------------------------------
        -- YNS1 Item
        ----------------------------------------------------------------
        ['yns1_key1'] = {
            label = '長照員鑰匙',--'筆記本',
            weight = 20,
            stack = true,
            close = true,
            consume = 0,
            description = '最後的機會 - 長照員 鑰匙',
            client = {
            }
        },
        ['yns1_key2'] = {
            label = '住戶鑰匙',--'筆記本',
            weight = 20,
            stack = true,
            close = true,
            consume = 0,
            description = '最後的機會 - 住房 鑰匙',
            client = {
            }
        },
        ['yns1_rules'] = {
            label = '收容守則',--'筆記本',
            weight = 2,
            stack = true,
            close = true,
            consume = 0,
            description = '背面寫著：2023年11月01日，長照員轉院而來',
        },
        ['yns1-gold'] = {
            label = '黃金礦',--'筆記本',
            weight = 800,
            stack = 1,
            close = 1,
            consume = 0,
            client = {
            }
        },
        ['yns1-notepad'] = {
            label = '莎草紙',--'筆記本',
            weight = 20,
            stack = false,
            close = true,
            consume = 0,
            description = '一寫上就無法擦去。',
            client = {
            }
        },
        ['yns1-pyrite'] = {
            label = '黃鐵礦',--'筆記本',
            weight = 1,
            description = '奇怪的物質，穩定待在背包或飄在旁邊，無法被物理破壞。',
            stack = 1,
            close = 1,
            consume = 0,
            client = {
            }
        },
        ['yns1-scarab'] = {
            label = '聖甲蟲',--'筆記本',
            weight = 800,
            stack = 1,
            close = 1,
            consume = 0,
            client = {
            }
        },
        ['yns1-hulahoop'] = {
            label = '呼拉圈',
            weight = 80,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-menu-taco'] = {
            label = '塔可菜單',--'筆記本',
            weight = 2000,
            stack = 0,
            close = 1,
            consume = 1,
            client = {
                status = {hunger = 2000000},
                anim = "eating",
                cancel = true,
                usetime = 20000,
                notification = "感覺很美味，跟吃紙餅乾一樣。"
            }
        },
        ['yns1-menu-burger'] = {
            label = '漢堡菜單',--'筆記本',
            weight = 2000,
            stack = 0,
            close = 1,
            consume = 1,
            client = {
                status = {hunger = 2000000},
                anim = "eating",
                cancel = true,
                usetime = 20000,
                notification = "感覺很美味，跟吃紙餅乾一樣。"
            }
        },
        ['yns1-menu-pizza'] = {
            label = '披薩菜單',--'筆記本',
            weight = 2000,
            stack = 0,
            close = 1,
            consume = 1,
            client = {
                status = {hunger = 2000000},
                anim = "eating",
                cancel = true,
                usetime = 20000,
                notification = "感覺很美味，跟吃紙餅乾一樣。"
            }
        },
        ['yns1-burger1'] = {
            label = '經典美式漢堡',--'筆記本',
            weight = 800,
            stack = 0,
            close = 1,
            consume = 1,
            description = '含芝麻麵包、牛肉排、生菜、番茄與醃黃瓜',
            client = {
                status = {hunger = 800000},
                anim = "eating",
                usetime = 8000,
                notification = " 牛肉的香味撲鼻而來，身心舒暢。"
            }
        },
        ['yns1-burger2'] = {
            label = '經典起司漢堡',--'筆記本',
            weight = 810,
            stack = 0,
            close = 1,
            consume = 1,
            description = '含芝麻麵包、牛肉排、生菜、番茄、醃黃瓜與美式起司',
            client = {
                status = {hunger = 810000},
                anim = "eating",
                usetime = 8100,
                notification = "起司鹹香充滿味蕾，酸黃瓜與生菜完美中和。"
            }
        },
        ['yns1-burger3'] = {
            label = '培根漢堡',--'筆記本',
            weight = 850,
            stack = 0,
            close = 1,
            consume = 1,
            description = '含芝麻麵包、牛肉排、生菜、番茄、醃黃瓜、美式起司、培根與燒烤醬',
            client = {
                status = {hunger = 850000},
                anim = "eating",
                usetime = 8500,
                notification = "培根酥脆與燒烤醬完美的碰撞，又多了幾股肥胖的衝動。"
            }
        },
        ['yns1-burger4'] = {
            label = '蘑菇漢堡(純素)',--'筆記本',
            weight = 650,
            stack = 0,
            close = 1,
            consume = 1,
            description = '含芝麻麵包、蘑菇排、生菜、番茄與醃黃瓜醬',
            client = {
                status = {hunger = 650000},
                anim = "eating",
                usetime = 6500,
                notification = "蘑菇的鮮香,讓減肥中的你又欺騙了自己一次。"
            }
        },
        ['yns1-burger5'] = {
            label = '美式搖搖薯(純素)',--'筆記本',
            weight = 150,
            stack = 0,
            close = 1,
            consume = 1,
            description = '含馬鈴薯、鹽與胡椒',
            client = {
                status = {hunger = 150000},
                anim = "eating",
                usetime = 1500,
                notification = "就是一份經典的美式薯條。"
            }
        },
        ['yns1-burger6'] = {
            label = '台式番薯條(純素)',--'筆記本',
            weight = 150,
            stack = 0,
            close = 1,
            consume = 1,
            description = '含好吃57號地瓜、鹽與胡椒',
            client = {
                status = {hunger = 150000},
                anim = "eating",
                usetime = 1500,
                notification = "地瓜的甜味伴隨著胡椒鹹香，是巷口小吃攤的經典味道。"
            }
        },
        ['yns1-burger7'] = {
            label = '墨西哥玉米片',--'筆記本',
            weight = 100,
            stack = 0,
            close = 1,
            consume = 1,
            description = '含玉米片、牛肉、莎莎醬與起司',
            client = {
                status = {hunger = 100000},
                anim = "eating",
                usetime = 1000,
                notification = "玉米片的酥脆搭配著莎莎醬，讓你一口接一口。"
            }
        },
        ['yns1-burger8'] = {
            label = '黃金薯塊(純素)',--'筆記本',
            weight = 250,
            stack = 0,
            close = 1,
            consume = 1,
            description = '含厚切馬鈴薯塊、麵包粉、鹽與胡椒',
            client = {
                status = {hunger = 250000},
                anim = "eating",
                usetime = 2500,
                notification = "豐滿的馬鈴薯在嘴巴炸開，小心燙口。"
            }
        },
        ['yns1-pizza1'] = {
            label = '原味起司披薩',
            description = '手工餅底經典起司披薩',
            weight = 1200,stack = 0,close = 1,consume = 1,
            client = {
                status = {hunger = 1200000},anim = "eating",
                usetime = 12000,notification = "起司的鹹加上厚餅皮的搭配，讓人欲罷不能。"
            }
        },
        ['yns1-pizza2'] = {
            label = '經典起司披薩配義大利辣肉腸',
            description = '手工餅底經典起司披薩',
            weight = 1400,stack = 0,close = 1,consume = 1,
            client = {
                status = {hunger = 1400000},anim = "eating",
                usetime = 14000,notification = "披薩上的辣肉腸超辣，辣到好像要噴火了。"
            }
        },
        ['yns1-pizza3'] = {
            label = '雙重饗宴披薩',
            description = '濃厚起司上鋪滿火腿與培根',
            weight = 1250,stack = 0,close = 1,consume = 1,
            client = {
                status = {hunger = 1250000},anim = "eating",
                usetime = 12500,notification = "培根的焦脆搭配火腿的鹹香，忍不住多吃幾口。"
            }
        },
        ['yns1-pizza4'] = {
            label = '奶香鮮蔬披薩',
            description = '濃厚起司上鋪滿橄欖，番茄，洋蔥及胡椒',
            weight = 1000,stack = 0,close = 1,consume = 1,
            client = {
                status = {hunger = 1000000},anim = "eating",
                usetime = 10000,notification = "橄欖配上蔬菜們，清爽而不膩口。"
            }
        },
        ['yns1-pizza5'] = {
            label = '菇菇派對披薩(純素)',
            description = '真正的素食薄餅，上面鋪滿多種蘑菇',
            weight = 1000,stack = 0,close = 1,consume = 1,
            client = {
                status = {hunger = 1000000},anim = "eating",
                usetime = 10000,notification = "薄皮的酥脆搭配蘑菇，讓你覺得不那麼邪惡。"
            }
        },
        ['yns1-pizza6'] = {
            label = '牧場物語披薩',
            description = '經典起司披薩上鋪滿四種肉類(雞、豬、牛與羊)',
            weight = 1250,stack = 0,close = 1,consume = 1,
            client = {
                status = {hunger = 1250000},anim = "eating",
                usetime = 12500,notification = "肉肉肉肉肉肉肉肉肉肉肉好多肉。"
            }
        },
        ['yns1-pizza7'] = {
            label = '起司交響曲披薩',
            description = '滿滿牽絲起司，滿足你的味蕾',
            weight = 1250,stack = 0,close = 1,consume = 1,
            client = {
                status = {hunger = 1250000},anim = "eating",
                usetime = 12500,notification = "Cheeeeeeeeeeeese~~ 小心燙口。"
            }
        },
        ['yns1-pizza8'] = {
            label = '山羊起司披薩',
            description = '紅白醬披薩配新鮮山羊起司',
            weight = 1300,stack = 0,close = 1,consume = 1,
            client = {
                status = {hunger = 1300000},anim = "eating",
                usetime = 13000,notification = "綿密的山羊起司搭配著紅醬在嘴裡爆開，讓人心曠神怡。"
            }
        },
        ['yns1-taco1'] = {
            label = '豬肉捲餅',
            description = '➕特製古巴醬汁',
            weight = 600,stack = 0,close = 1,consume = 1,
            client = {
                status = {hunger = 600000},anim = "eating",
                usetime = 6000,notification = "醬汁的鹹香伴隨著豬肉的爽脆好吃到連醬汁都一滴不剩。"
            }
        },
        ['yns1-taco2'] = {
            label = '海鮮捲餅',
            description = '➕生菜與芒果莎莎醬',
            weight = 598,stack = 0,close = 1,consume = 1,
            client = {
                status = {hunger = 589000},anim = "eating",
                usetime = 5980,notification = "芒果莎莎醬配上炸鱈魚，爽而不膩。"
            }
        },
        ['yns1-taco3'] = {
            label = '牛肉捲餅',
            description = '➕生菜沙拉',
            weight = 632,stack = 0,close = 1,consume = 1,
            client = {
                status = {hunger = 632000},anim = "eating",
                usetime = 6320,notification = "taco。"
            }
        },
        ['yns1-punish'] = {
            label = '肉醬義大利麵',
            weight = 600,
            stack = 0,
            close = 1,
            consume = 1,
            description = '看起來非常美味可口，肉醬血紅紅的嘗起來你感覺肉醬有股說不出神秘又熟悉的味道，甚麼肉? 你嘗不出來。',
            client = {
                status = {hunger = 600000},
                anim = "eating",
                usetime = 6000,
            }
        },
        ['yns1-punish2'] = {
            label = '番茄湯',
            weight = 300,
            stack = 0,
            close = 1,
            consume = 1,
            description = '鮮紅濃稠，聞起來番茄鹹甜鮮味濃厚，嘗起來會有一股熟悉的味道，湯中有些肉沫碎塊咬起來軟嫩，仔細品味有股說不出的味道。',
            client = {
                status = {hunger = 200000,thirst = 100000},
                anim = "eating",
                usetime = 3000,
            }
        },
        ['crutch'] = {
            label = '拐杖',
            weight = 165,
            stack = false,
            close = true,
            description = '',
            client={
                event = 'CF_General:UseCrutch'
            }
        },
        ['crutch2'] = {
            label = '拐杖',
            weight = 165,
            stack = false,
            close = true,
            description = '',
            client={
                event = 'CF_General:UseCrutch2'
            }
        },
        ['wheelchair'] = {
            label = '攜帶式輪椅',
            weight = 544,
            stack = false,
            close = true,
        },
        ['yns1-look2'] = {
            label = '最後的機會地圖',--'筆記本',
            weight = 1,
            stack = 1,
            close = 1,
            consume = 0,
        },
        ['yns1-glassescloth'] = {
            label = '眼鏡布',--'筆記本',
            weight = 5,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-phototransfer'] = {
            label = '照印機',--'筆記本',
            weight = 250,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-photo'] = {
            label = '相片紙',--'筆記本',
            weight = 5,
            stack = 1,
            close = 1,
            consume = 0,
        },
        ['yns1-cft0001-1'] = {
            label = '論文紙張',
            weight = 5,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-cft0001-1'] = {
            label = '論文紙張',
            weight = 5,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-cft0001-2'] = {
            label = '認識人性',
            weight = 240,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-cft0001-3'] = {
            label = '衝突的力量',
            weight = 253,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-cft0001-4'] = {
            label = '戰爭中的殺人心理',
            weight = 300,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-cft0001-5'] = {
            label = '我和你',
            weight = 30,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-cft0001-6'] = {
            label = '團員',
            weight = 30,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-cft0001-7'] = {
            label = '醬油拉麵',
            weight = 800,
            stack = 0,
            close = 1,
            consume = 1,
            client = {
                status = {hunger = 800000},
                anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
                usetime = 8000,
            }
        },
        ['yns1-cft0001-8'] = {
            label = '肌肉鬆弛劑',
            weight = 1,
            stack = 0,
            close = 1,
            consume = 1,
            client = {
                anim = {dict = "wolf@awesome@asset", clip = "pill"},
                usetime = 2500},
        },
        ['yns1-cft0001-9'] = {
            label = '胃藥',
            weight = 1,
            stack = 0,
            close = 1,
            consume = 1,
            client = {
                anim = {dict = "wolf@awesome@asset", clip = "pill"},
                usetime = 2500},
        },
        ['yns1-cs0004-1'] = {
            label = '鮮蝦麵',
            weight = 250,
            stack = 0,
            close = 1,
            consume = 1,
            client = {
                status = {hunger = 250000},
                anim = "eating",
                usetime = 2500,
            }
        },
        ['yns1-cs0004-2'] = {
            label = '血栓溶解劑',
            weight = 100,
            stack = 1,
            close = 1,
            consume = 1,
        },
        ['yns1-cs0005-1'] = {
            label = '中華香菸',
            description = '寫著中華的香菸',
            weight = 40,
            stack = 1,
            close = 1,
            consume = 0.05,
            client = {
                usetime = 2500
            }
        },
        ['yns1-cs0005-2'] = {
            label = '陳舊的相框',
            weight = 260,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-cs0005-3'] = {
            label = '年長女性的照片',
            description = '保存良好',
            weight = 5,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-cs0008-1'] = {
            label = '園藝組（工具）',
            weight = 600,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-cs0008-2'] = {
            label = '世彰安養中心藥包',
            description = '副作用會有嗜睡跟嘔吐的效果',
            weight = 20,
            stack = 1,
            close = 1,
            consume = 1,
            client = {
                anim = "eating",
                usetime = 1500,
            }
        },
        ['yns1-cs0008-3'] = {
            label = '園藝組（肥料）',
            weight = 200,
            stack = 1,
            close = 1,
            consume = 0,
        },
        ['yns1-cs0008-4'] = {
            label = '園藝組（灑水器）',
            weight = 100,
            stack = 1,
            close = 1,
            consume = 0,
        },
        ['yns1-cs0008-5'] = {
            label = '樹木圖鑑',
            description = '夾著一個楓葉書籤',
            weight = 80,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-cs0008-6'] = {
            label = '防尿墊',
            weight = 300,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-cs0008-7'] = {
            label = '穿戴式接尿器',
            weight = 700,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-cs0008-8'] = {
            label = '成人尿布',
            weight = 150,
            stack = 1,
            close = 1,
            consume = 0,
        },
        ['yns1-cs0009-1'] = {
            label = '白色花瓣',
            description = '仔細聞有淡雅香氣',
            weight = 1,
            stack = 1,
            close = 1,
            consume = 0,
        },
        ['yns1-cs0009-2'] = {
            label = '紙船',
            description = '摺好的紙船',
            weight = 10,
            stack = 0,
            close = 1,
            consume = 1,
        },
        ['yns1-cs0009-3'] = {
            label = '紙條塗鴉',
            weight = 1,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-cs0011-1'] = {
            label = '水餃',
            description = '裏頭包著高麗菜、韭菜、豬肉餡，內餡兒是隨機的！',
            weight = 600,
            stack = 0,
            close = 1,
            consume = 1,
            client = {
                status = {hunger = 300000},
                anim = "eating",
                usetime = 3000,
            }
        },
        ['yns1-cs0011-2'] = {
            label = '地瓜粥',
            description = '幾個地瓜丟進去，蒸熟就給您的地瓜粥，吃起來一點點甜，但毫無樂趣！',
            weight = 350,
            stack = 0,
            close = 1,
            consume = 1,
            client = {
                status = {hunger = 175000},
                anim = "eating",
                usetime = 2750,
            }
        },
        ['yns1-cs0011-3'] = {
            label = '水煮雞肉',
            description = '加了少許鹽巴的雞肉，吃起來只有鹽巴的感覺，毫無樂趣',
            weight = 100,
            stack = 1,
            close = 1,
            consume = 1,
            client = {
                status = {hunger = 50000},
                anim = "eating",
                usetime = 2000,
            }
        },
        ['yns1-cs0011-10'] = {
            label = '雞肉',
            description = '就是一塊雞肉，不是田雞，不可生吃',
            weight = 100,
            stack = 1,
            close = 1,
            consume = 1,
            client = {
                status = {hunger = 50000},
                anim = "eating",
                usetime = 1000,
            }
        },
        ['yns1-cs0011-4'] = {
            label = '寄命紙',
            description = '費登 ，寄命土地公、虎爺，平平安安回來',
            weight = 10,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-cs0011-5'] = {
            label = '寄命紙',
            description = '林鴻堂 ，寄命土地公、虎爺，平平安安回來',
            weight = 10,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-cs0011-6'] = {
            label = '寄命紙',
            description = '雷平安 ，寄命土地公、虎爺，平平安安回來',
            weight = 10,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-cs0011-7'] = {
            label = '寄命紙',
            description = '黃少興 ，寄命土地公、虎爺，平平安安回來',
            weight = 10,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-cs0011-8'] = {
            label = '寄命紙',
            description = '費囍 ，寄命土地公、虎爺，平平安安回來',
            weight = 10,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-cs0011-9'] = {
            label = '寄命紙',
            description = '孫枝娟 ，寄命土地公、虎爺，平平安安回來',
            weight = 10,
            stack = 0,
            close = 1,
            consume = 0,
        },
        ['yns1-cs0013-1'] = {
            label = '熱茶',
            weight = 200,
            stack = 0,
            close = 1,
            consume = 1,
            client = {
                status = {thirst = 200000},
                anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
                usetime = 2000,
            }
        },
        ['yns1-cs0013-2'] = {
            label = '不熟的橘子',
            weight = 200,
            stack = 0,
            close = 1,
            consume = 1,
            client = {
                status = {hunger = 200000},
                anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
                usetime = 2000,
            }
        },
        ['yns1-cs0013-3'] = {
            label = '成熟的橘子',
            weight = 800,
            stack = 0,
            close = 1,
            consume = 1,
            client = {
                status = {hunger = 800000},
                anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
                usetime = 8000,
            }
        },
        ['yns1-medi1'] = {description = 'β- blocker',label = '強心劑',weight = 5,stack = 1,close = 1,consume = 1,},
        ['yns1-medi2'] = {description = '所有手術道具',label = '全套醫療刀具',weight = 550,stack = 0,close = 1,consume = 0,},
        ['yns1-medi3'] = {description = 'Hydrocortisone',label = '類固醇',weight = 5,stack = 1,close = 1,consume = 1,},
        ['yns1-medi4'] = {description = 'Morphine',label = '止痛液',weight = 5,stack = 1,close = 1,consume = 1,},
        ['yns1-medi5'] = {description = 'Tranquilizer',label = '鎮定劑',weight = 5,stack = 1,close = 1,consume = 1,},
        ['yns1-medi6'] = {description = 'Epinephrine',label = '腎上腺素',weight = 5,stack = 1,close = 1,consume = 1,},
        ['yns1-medi7'] = {description = 'β-lactam,請勿和Glycopeptide同時使用',label = '抗生素',weight = 5,stack = 1,close = 1,consume = 1,},
        ['yns1-medi8-1'] = {description = '內含A型全血250cc',label = '血袋',weight = 300,stack = 0,close = 1,consume = 1,},
        ['yns1-medi8-2'] = {description = '內含B型全血250cc',label = '血袋',weight = 300,stack = 0,close = 1,consume = 1,},
        ['yns1-medi8-3'] = {description = '內含AB型全血250cc',label = '血袋',weight = 300,stack = 0,close = 1,consume = 1,},
        ['yns1-medi8-4'] = {description = '內含O型全血250cc',label = '血袋',weight = 300,stack = 0,close = 1,consume = 1,},
        ['yns1-medi9'] = {description = '與Norepinephrine同時使用',label = '生壓劑',weight = 5,stack = 1,close = 1,consume = 1,},
        ['yns1-medi10'] = {description = '與Dopamine同時使用',label = '血管收縮劑',weight = 5,stack = 1,close = 1,consume = 1,},
        ['yns1-medi11'] = {description = 'Suction',label = '抽吸器',weight = 100,stack = 1,close = 1,consume = 0,},
        ['yns1-medi12'] = {description = 'ENDO',label = '氣管內管',weight = 100,stack = 1,close = 1,consume = 0,},
        ['yns1-medi13'] = {description = 'Thrombin',label = '凝血酶',weight = 100,stack = 1,close = 1,consume = 1,},
        ----------------------------------------------------------------
        -- FSZ1 Item
        ----------------------------------------------------------------

        ['fs_brokenphone'] = {
            label = '壞掉手機',
            weight = 100,
            stack = false,
            close = true,
            consume = 0,
            description = '無論怎麼使用，都沒有回應。',
        },
        ['fs_brokenradio'] = {
            label = '壞掉無線電',
            weight = 100,
            stack = false,
            close = true,
            consume = 0,
            description = '無論怎麼使用，都沒有回應。',
        },
        ['fs_blood1'] = {
            label = '鮮血紙條',
            weight = 1,
            stack = false,
            close = true,
            consume = 0,
            description = '沾滿血的紙條',
        },
        ['fs_blood2'] = {
            label = '鮮血紙條',
            weight = 1,
            stack = false,
            close = true,
            consume = 0,
            description = '沾滿血的紙條',
        },
        ['fs_movie1'] = {
            label = '影片截圖',
            weight = 1,
            stack = false,
            close = true,
            consume = 0,
            description = '影音平台的某部影片截圖',
        },
        ['fs_needle'] = {
            label = '奶奶的針',
            weight = 5,
            stack = false,
            close = true,
            consume = 0,
            description = '乍看之下只是個普通的針，但可以感覺到很溫暖的氣息。',
        },
        ['fs_evil'] = {
            label = '惡魔之書',
            weight = 6666,
            stack = false,
            close = true,
            consume = 0,
            description = '上面依序寫著劉少欽、簡愛美、歐陽薰、陳甄、伊琪婉、程冠漪、李以恩、孫仲天、南宮翎、李展青。最底下浮現一行字「死仇不報，此書不滅。欲滅此書，尋親鋒芒，破其封扉」',
        },
        ['fs_medicenrecord'] = {
            label = '診療紀錄',
            weight = 1,
            stack = false,
            close = true,
            consume = 0,
            description = '某醫院的就醫診療紀錄，上面的字跡很模糊閱讀起來有點吃力。',
        },
        ['fs_medicenrecord2'] = {
            label = '陳舊的診斷證明',
            weight = 1,
            stack = false,
            close = true,
            consume = 0,
            description = '李展青的就醫診斷紀錄。',
        },
        ['fs_dirtynote'] = {
            label = '髒紙條',--'筆記本',
            weight = 1,
            stack = false,
            close = true,
            consume = 0,
            description = '被揉過又攤平，很髒。',
        },
        ['fs_olddiary'] = {
            label = '潮濕捲曲的破舊日記本',--'筆記本',
            weight = 90,
            stack = false,
            close = true,
            consume = 0,
            description = '大部分內容都被撕掉了，還留在上面的字跡糊在一起看不清。',
        },
        ['fs_brokendiary'] = {
            label = '日記殘頁',
            weight = 1,
            stack = false,
            close = true,
            consume = 0,
        },
        ['fs_diary1'] = {
            label = '李展青的日記殘片1',--'筆記本',
            weight = 3,
            stack = false,
            close = true,
            consume = 0,
            description = '一本使用痕跡累累的日記本，不知道為什麼紙張有種被水沾濕過又乾涸的捲曲感。',
        },
        ['fs_diary2'] = {
            label = '李展青的日記殘片2',--'筆記本',
            weight = 3,
            stack = false,
            close = true,
            consume = 0,
            description = '一本使用痕跡累累的日記本，不知道為什麼紙張有種被水沾濕過又乾涸的捲曲感。',
        },
        ['fs_ig1'] = {
            label = 'IG截圖影本1',--'筆記本',
            weight = 3,
            stack = false,
            close = true,
            consume = 0,
            description = '不知道是誰印下來的IG截圖。',
        },
        ['fs_ig2'] = {
            label = 'IG截圖影本2',--'筆記本',
            weight = 3,
            stack = false,
            close = true,
            consume = 0,
            description = '不知道是誰印下來的IG截圖。',
        },
        ['fs_ig3'] = {
            label = 'IG截圖影本3',--'筆記本',
            weight = 3,
            stack = false,
            close = true,
            consume = 0,
            description = '不知道是誰印下來的IG截圖。',
        },
        ['fs_destroy1'] = {
            label = '被撕毀的作業',--'筆記本',
            weight = 3,
            stack = false,
            close = true,
            consume = 0,
            description = '無法辨識是誰的作業，隱約能看到成績非常高。',
        },
        ['fs_destroy2'] = {
            label = '破舊書包' ,-- '被毀損的書包',--'筆記本',
            weight = 200,
            stack = false,
            close = true,
            consume = 0,
            description = '上面佈滿污痕與惡意破壞的痕跡。',
        },
        ['fs_destroy3'] = {
            label = '髒亂的制服',--'筆記本',
            weight = 200,
            stack = false,
            close = true,
            consume = 0,
            description = '沾滿了泥土、髒污的制服…上面繡字處只隱約看得出來「子」「月」。',
        },
        ['fs_loveletter'] = {
            label = '陳舊的情書',--'筆記本',
            weight = 5,
            stack = false,
            close = true,
            consume = 0,
            description = '被揉爛的女用信紙，信封上寫著李展青以及沒黏性的愛心貼紙。內文模糊不清，但依稀看得出屬名者為陳甄。',
        },
        ['fs_deathnote'] = {
            label = '死亡證明書',--'筆記本',
            weight = 2,
            stack = false,
            close = true,
            consume = 0,
            description = '一張陳舊的證明文件',
        },
        ['fs_notepage'] = {
            label = '嘲笑紙條',--'筆記本',
            weight = 1,
            stack = false,
            close = true,
            consume = 0,
            description = '上面寫著謾罵的字眼',
        },
        ['fs_note7'] = {
            label = '紙條',--'筆記本',
            weight = 1,
            stack = false,
            close = true,
            consume = 0,
            description = '上面寫著威脅某人到天臺的文字',
        },
        ['fs_note8'] = {
            label = '嘲笑紙條',--'筆記本',
            weight = 1,
            stack = false,
            close = true,
            consume = 0,
            description = '上面寫著謾罵的字眼',
        },
        ['fs_note9'] = {
            label = '嘲笑紙條',--'筆記本',
            weight = 1,
            stack = false,
            close = true,
            consume = 0,
            description = '上面寫著謾罵的字眼',
        },
        ['fs_note10'] = {
            label = '嘲笑紙條',--'筆記本',
            weight = 1,
            stack = false,
            close = true,
            consume = 0,
            description = '上面寫著謾罵的字眼',
        },

        ----------------------------------------------------------------
        -- Technology Testing Item
        ----------------------------------------------------------------

        ['devitems'] = {
            label = '技術組物品',
            weight = 0,
            consume = 0,
        },
        ["clothing"] = {
            label = "衣服",
            consume = 0
        },
        ['template_food'] = {
            label = ' ',
            weight = 300,
            client = {
                anim = 'eating',
                prop = 'burger',
                usetime = 2500,
            },
        },
        ['template_drink'] = {
            label = ' ',
            weight = 300,
            client = {
                anim = 'drinking',
                prop = 'bottle',
                usetime = 2500,
            },
        },
        ['template_useonly'] = {
            label = ' ',
            weight = 300,
            client = {
                usetime = 2500,
            }
        },
        ['template_normal'] = {
            label = ' ',
            weight = 300,
        },

        ["whalepic_effectcard"] = {
            label = "特效晶片卡",
            weight = 20,
            stack = true,
            close = true,
            consume = 1,
            description = "卡片上寫著一行字：特效微型晶片卡"
        },
        ["whalepic_abilitycard"] = {
            label = "能力晶片卡",
            weight = 20,
            stack = true,
            close = true,
            consume = 1,
            description = "卡片上寫著一行字：訓練微型晶片卡"
        },
        ["whalepic_specialcard"] = {
            label = "特殊晶片卡",
            weight = 20,
            stack = true,
            close = true,
            consume = 1,
            description = "卡片上寫著一行字：特殊微型晶片卡"
        },
        ----------------------------------------------------------------
        -- Unsort Item
        ----------------------------------------------------------------
        ["golfbagx"] = {
            label = "高爾夫球袋",
            weight = 1000,
            stack = false,
            close = true,
        },
        ["testburger"] = {
            label = "Test Burger",
            weight = 220,
            degrade = 0.2,
            limit = 3,
            client = {
                status = {hunger = 200000},
                anim = "eating",
                prop = "burger",
                usetime = 2500,
                export = "ox_inventory_examples.testburger"
            },
            server = {
                test = "what an amazingly delicious burger, amirite?"
            }
        },
        ["scrapmetal"] = {
            label = "Scrap Metal",
            weight = 80
        },
        ["bironlack_spray_paint"] = {
            label = "xxx",
            weight = 23,
            stack = 1,
            close = 1,
            description = ""
        },
        ["W1-1"] = {
            label = "煙火筒",
            weight = 50,
            stack = 1,
            close = 1,
            description = "煙火筒",
            client = {
                usetime = 2500
            }
        },
        ["jingxaingflower"] = {
            label = "璟湘花",
            weight = 21,
            stack = 1,
            close = 1,
            description = ""
        },
        ["medicinepackage_double"] = {
            label = "特效藥",
            weight = 300,
            stack = 1,
            close = 1,
            description = "雙倍",
            client = {
                usetime = 2500
            }
            -- client = {
            --   status = {},
            --   anim = { dict = 'wolf@awesome@asset', clip = 'pill' },
            --   -- prop = { model = 'prop_cs_burger_01', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
            --   usetime = 2500,
            -- }
        },
        ["prop_detector"] = {
            label = "金屬探測器",
            weight = 1500,
            stack = 1,
            close = 1,
            description = "金屬探測器"
        },
        ["shock_absorber"] = {
            label = "荊棘草",
            weight = 100,
            stack = true,
            close = true
        },
        ["garett"] = {
            label = "荊棘草",
            weight = 100,
            stack = true,
            close = true
        },
        ["paperbag"] = {
            label = "包包",
             --'荊棘草',
            weight = 1,
            stack = false,
            close = false,
            consume = 0,
        },
        ["pizzabox"] = {
            label = "披薩盒",
             -- '包包',
            weight = 1,
            stack = false,
            close = false,
            consume = 0,
        },
        ["piston"] = {
            label = "荊棘草",
            weight = 100,
            stack = true,
            close = true
        },
        ["rod"] = {
            label = "荊棘草",
            weight = 100,
            stack = true,
            close = true
        },
        ["gear"] = {
            label = "荊棘草",
            weight = 100,
            stack = true,
            close = true
        },
        ["aluminum"] = {
            label = "荊棘草",
            weight = 100,
            stack = true,
            close = true
        },
        ["brake_discs"] = {
            label = "荊棘草",
            weight = 100,
            stack = true,
            close = true
        },
        ["brake_caliper"] = {
            label = "荊棘草",
            weight = 100,
            stack = true,
            close = true
        },
        ["shock_absorber"] = {
            label = "荊棘草",
            weight = 100,
            stack = true,
            close = true
        },
        ["springs"] = {
            label = "荊棘草",
            weight = 100,
            stack = true,
            close = true
        },
        ["golf"] = {
            label = "高爾夫球(白)",
            weight = 10,
            stack = true,
            close = true,
            consume = 0,
            client = {
                usetime = 0
            }
        },
        ["golf_yellow"] = {
            label = "高爾夫球(黃)",
            weight = 10,
            stack = true,
            close = true,
            client = {
                usetime = 0
            }
        },
        ["golf_green"] = {
            label = "高爾夫球(綠)",
            weight = 10,
            stack = true,
            close = true,
            client = {
                usetime = 0
            }
        },
        ["golf_pink"] = {
            label = "高爾夫球(粉)",
            weight = 10,
            stack = true,
            close = true,
            client = {
                usetime = 0
            }
        },
        ["blk"] = {
            label = "巴洛克家徽",
            weight = 50,
            stack = true,
            close = true
        },
        ["rtjuice"] = {
            label = "阿天果汁",
            weight = 144,
            stack = true,
            close = true,
            client = {
                status = {thirst = 196500},
                anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
                prop = {
                    model = "prop_ecola_can",
                    pos = {x = 0.010000000000002, y = 0.010000000000002, y = 0.060000000000002},
                    rot = {x = 5.0, y = 5.0, y = -180.5}
                },
                usetime = 2500
            }
        },
        ["ricejuice"] = {
            label = "米漿",
            weight = 144,
            stack = true,
            close = true,
            client = {
                status = {thirst = 196500},
                anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
                prop = {
                    model = "prop_ecola_can",
                    pos = {x = 0.010000000000002, y = 0.010000000000002, y = 0.060000000000002},
                    rot = {x = 5.0, y = 5.0, y = -180.5}
                },
                usetime = 2500
            }
        },
        ["medicinepackage2_double"] = {
            label = "費氏特效小藥包",
            weight = 180,
            stack = true,
            close = true,
            description = "雙倍",
            client = {
                status = {thirst = -8000},
                anim = {dict = "wolf@awesome@asset", clip = "pill"},
                -- prop = { model = 'prop_ld_flow_bottle', pos = { x = 0.030000000000002, y = 0.030000000000002, y = 0.020000000000004}, rot = { x = 0.0, y = 0.0, y = -1.5} },
                usetime = 2500
            }
        },
        ["identification"] = {
            label = "身分證",
            weight = 0,
            stack = true,
            close = true
        },
        ["ve_matral"] = {
            label = "載具材料",
            weight = 400,
            stack = true,
            close = true
        },
        ["shineshell"] = {
            label = "晶貝",
            weight = 150,
            stack = true,
            close = true,
            description = "製成亮鯨金的原料，可高價出售給契拉家。"
        },
        ["seasalt"] = {
            label = "海岩鹽",
            weight = 11,
            stack = true,
            close = true,
            description = "附著在海岸的礦物的鹽份，與礦物本身的物質結合，形成特別的海岩鹽。"
        },
        ["prop_bones"] = {
            label = "骨頭",
            weight = 150,
            stack = true,
            close = true
        },
        ["prop_dragon_scales"] = {
            label = "特殊鱗片",
            weight = 100,
            stack = true,
            close = true
        },
        ["prop_metalscrap"] = {
            label = "金屬廢料",
            weight = 150,
            stack = true,
            close = true
        },
        ["prop_nuts_and_bolts"] = {
            label = "螺母和螺栓",
            weight = 150,
            stack = true,
            close = true
        },
        ["petroleum"] = {
            label = "原油",
            weight = 80,
            stack = true,
            close = true
        },
        ["fixed"] = {
            label = "固定器",
            weight = 600,
            stack = true,
            close = true
        },
        ["custom_pack"] = {
            label = "改車包",
            weight = 250,
            stack = true,
            close = true
        },
        ["coffeebeans"] = {
            label = "咖啡豆",
            weight = 75,
            stack = true,
            close = true,
            description = "咖啡豆"
        },
        ["cryfruit"] = {
            label = "鯨淚果",
            weight = 60,
            stack = true,
            close = true,
            consume = 1,
            client = {
                status = {hunger = 16000},
                anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
                prop = {
                    model = "prop_cs_burger_01",
                    pos = {x = 0.02, y = 0.02, z = -0.02},
                    rot = {x = 0.0, y = 0.0, z = 0.0}
                },
                usetime = 2500
            }
        },
        ["pork"] = {
            label = "肉",
            weight = 100,
            stack = true,
            close = true,
            description = "肉",
            consume = 1,
            client = {
                status = {hunger = 45000, thirst = 0, drunk = 0},
                anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
                prop = {
                    model = "prop_cs_burger_01",
                    pos = {x = 0.02, y = 0.02, z = -0.02},
                    rot = {x = 0.0, y = 0.0, z = 0.0}
                },
                usetime = 2500
            }
        },
        ["rtainfruit"] = {
            label = "阿天果",
            weight = 120,
            stack = true,
            close = true,
            consume = 1,
            client = {
                status = {hunger = 44600},
                anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
                prop = {
                    model = "prop_cs_burger_01",
                    pos = {x = 0.02, y = 0.02, z = -0.02},
                    rot = {x = 0.0, y = 0.0, z = 0.0}
                },
                usetime = 2500
            }
        },
        ["quartz"] = {
            label = "石英",
            weight = 50,
            stack = true,
            close = true
        },
        ["score8"] = {
            label = "分數八",
            weight = 0,
            stack = true
        },
        ["rake"] = {
            label = "扒子",
            weight = 100,
            stack = 0,
            close = 1,
            description = ""
        },
        ["green_melon"] = {
            label = "史蒂尼綠黃瓜碳酸飲料",
            weight = 10,
            stack = true,
            close = 0,
            consume = 1,
            description = "史蒂尼綠黃瓜碳酸飲料",
            client = {
                status = {drunk = 100000},
                anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
                prop = {
                    model = "prop_ld_flow_bottle",
                    pos = {x = 0.03, y = 0.03, z = 0.02},
                    rot = {x = 0.0, y = 0.0, z = -1.5}
                },
                usetime = 5700
            }
        },
        ["red_melon"] = {
            label = "史班尼紅蘋果碳酸飲料",
            weight = 100,
            stack = 1,
            close = 0,
            consume = 1,
            description = "史班尼紅蘋果碳酸飲料",
            client = {
                status = {drunk = 100000},
                anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
                prop = {
                    model = "prop_ld_flow_bottle",
                    pos = {x = 0.03, y = 0.03, z = 0.02},
                    rot = {x = 0.0, y = 0.0, z = -1.5}
                },
                usetime = 5700
            }
        },
        ["yellow_melon"] = {
            label = "史齊尼黃梨子碳酸飲料",
            weight = 100,
            stack = 1,
            close = 0,
            consume = 1,
            description = "史齊尼黃梨子碳酸飲料",
            client = {
                status = {drunk = 100000},
                anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
                prop = {
                    model = "prop_ld_flow_bottle",
                    pos = {x = 0.03, y = 0.03, z = 0.02},
                    rot = {x = 0.0, y = 0.0, z = -1.5}
                },
                usetime = 5700
            }
        },
        ["bon_book3"] = {
            label = "光與影-康×管同人本",
            weight = 100,
            stack = false,
            close = true,
            consume = 0,
            description = "知名偶像劇的創作同人本",
            client = {
                usetime = 0
            }
        },
        ["hao_pic"] = {
            label = "沈老師的回憶",
            weight = 10,
            stack = 1,
            close = 1,
            consume = 0,
            description = "",
            client = {
                usetime = 2500
            }
        },
        ["r7_hun"] = {
            label = "混一步燒肉飯",
            weight = 184,
            stack = true,
            close = true,
            consume = 1,
            client = {
                status = {hunger = 280000},
                anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
                prop = {
                    model = "prop_cs_burger_01",
                    pos = {x = 0.02, y = 0.02, z = -0.02},
                    rot = {x = 0.0, y = 0.0, z = 0.0}
                },
                usetime = 2500
            }
        },
        ["lemonjuice"] = {
            label = "檸檬汁",
            weight = 30,
            stack = 1,
            description = "",
            client = {
                status = {thirst = 70000},
                anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
                prop = {model = "prop_ld_flow_bottle", pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5)},
                usetime = 2500
            }
        },
        ["s_cranberry_scones"] = {
            label = "蔓越莓司康",
            weight = 30,
            stack = 1,
            description = "",
            client = {
                status = {hunger = 150000},
                anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
                prop = {
                    model = "prop_cs_burger_01",
                    pos = {x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004},
                    rot = {x = 0.0, y = 0.0, y = 0.0}
                },
                usetime = 2500
            }
        },
        ["s_lemontea"] = {
            label = "檸檬馬鞭草茶",
            weight = 30,
            stack = 1,
            description = "",
            client = {
                status = {thirst = 100000},
                anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
                prop = {model = "prop_ld_flow_bottle", pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5)},
                usetime = 2500
            }
        },
        ["pio_jager"] = {
            label = "野格",
            weight = 170,
            stack = true,
            close = true,
            description = "野格",
            consume = 1,
            client = {
                status = {drunk = 600000},
                anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
                prop = {
                    model = "prop_ld_flow_bottle",
                    pos = {x = 0.03, y = 0.03, z = 0.02},
                    rot = {x = 0.0, y = 0.0, z = -1.5}
                },
                usetime = 1500
            }
        },
        ["gua_blood"] = {
            label = "取血針",
            weight = 10,
            stack = true,
            close = true,
            consume = 1,
            client = {
                status = {},
                usetime = 3500
            }
        },
        ["shi_deer"] = {
            label = "烤鹿排",
            weight = 150,
            stack = true,
            close = true,
            consume = 1,
            description = "",
            client = {
                status = {hunger = 300000, thirst = -60000},
                anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
                prop = {
                    model = "prop_cs_burger_01",
                    pos = {x = 0.02, y = 0.02, z = -0.02},
                    rot = {x = 0.0, y = 0.0, z = 0.0}
                },
                usetime = 2500
            }
        },
        ["shi_sushi"] = {
            label = "壽司",
            weight = 170,
            stack = true,
            close = true,
            consume = 1,
            description = "",
            client = {
                status = {hunger = 300000},
                anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
                prop = {
                    model = "prop_cs_burger_01",
                    pos = {x = 0.02, y = 0.02, z = -0.02},
                    rot = {x = 0.0, y = 0.0, z = 0.0}
                },
                usetime = 2500,
                notification = ""
            }
        },
        ["news0210"] = {
            label = "報紙0206-0210",
            weight = 50,
            stack = true,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["lulu_cardbrown"] = {
            label = "布朗妮簽名小卡",
            weight = 100,
            stack = true,
            close = true,
            consume = 0,
            description = "上面印有布朗妮娃娃圖樣的小卡片，可以用來簽名。卡片背後有一行小字。",
            client = {}
        },
        ["bear_bearcupcake"] = {
            label = "小熊杯子蛋糕",
            weight = 250,
            stack = true,
            close = true,
            consume = 1,
            description = "",
            client = {
                status = {hunger = 10000},
                anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
                prop = {
                    model = "prop_cs_burger_01",
                    pos = {x = 0.02, y = 0.02, z = -0.02},
                    rot = {x = 0.0, y = 0.0, z = 0.0}
                },
                usetime = 500,
                notification = ""
            }
        },
        ["hlin_longansoup"] = {
            label = "桂圓紅棗湯",
            weight = 450,
            stack = false,
            close = true,
            consume = 1,
            description = "",
            client = {
                status = {hunger = 200000, thirst = 300000},
                anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
                prop = {
                    model = "prop_ld_flow_bottle",
                    pos = {x = 0.03, y = 0.03, z = 0.02},
                    rot = {x = 0.0, y = 0.0, z = -1.5}
                },
                usetime = 1500,
                notification = ""
            }
        },
        ["logo10"] = {
            label = "logo",
            weight = 5,
            stack = true,
            close = true,
            consume = 0
        },
        ["g1_needle_holder"] = {
            label = "持針器",
            weight = 50,
            stack = false,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_oilcan"] = {
            label = "汽油桶",
            weight = 1000,
            stack = false,
            close = true,
            consume = 1,
            description = "",
            client = {}
        },
        ["g1_toothpaste"] = {
            label = "牙膏",
            weight = 150,
            stack = false,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_opener2"] = {
            label = "開瓶器",
            weight = 150,
            stack = false,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_body_1"] = {
            label = "斷肢1",
            weight = 50,
            stack = true,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_body_2"] = {
            label = "斷肢2",
            weight = 100,
            stack = true,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_body_3"] = {
            label = "斷肢3",
            weight = 350,
            stack = false,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_body_4"] = {
            label = "斷肢4",
            weight = 450,
            stack = false,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_body_5"] = {
            label = "斷肢5",
            weight = 350,
            stack = false,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_strawmachi"] = {
            label = "草莓麻糬",
            weight = 50,
            stack = true,
            close = true,
            consume = 1,
            description = "",
            client = {
                status = {hunger = 150000},
                anim = "eating",
                prop = "burger",
                usetime = 1500,
                notification = ""
            }
        },
        ["g1_3931_can1"] = {
            label = "一公升軍用水壺(空)",
            weight = 15,
            stack = false,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_3931_blanket"] = {
            label = "法蘭絨單人毛毯",
            weight = 650,
            stack = false,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_5938_food1"] = {
            label = "醃肉罐",
            weight = 1800,
            stack = false,
            close = true,
            consume = 1,
            description = "",
            client = {
                status = {hunger = 500000},
                anim = "eating",
                prop = "burger",
                usetime = 1500,
                notification = ""
            }
        },
        ["g1_0275_fruit"] = {
            label = "水果乾",
            weight = 400,
            stack = true,
            close = true,
            consume = 1,
            description = "",
            client = {
                status = {hunger = 350000},
                anim = "eating",
                prop = "burger",
                usetime = 1500,
                notification = ""
            }
        },
        ["g1_1864_book"] = {
            label = "畫冊",
            weight = 1600,
            stack = false,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_1miao"] = {
            label = "疫苗",
            weight = 10,
            stack = true,
            close = true,
            consume = 1,
            description = "蕭院長製作的疫苗",
            client = {
                notification = ""
            }
        },
        ["g1_3583_chicken"] = {
            label = "香煎雞胸肉",
            weight = 300,
            stack = true,
            close = true,
            consume = 1,
            description = "",
            client = {
                status = {hunger = 300000},
                anim = "eating",
                prop = "burger",
                usetime = 1500
            }
        },
        ["g1_3583_fish"] = {
            label = "生魚片",
            weight = 200,
            stack = true,
            close = true,
            consume = 1,
            description = "",
            client = {
                status = {hunger = 200000},
                anim = "eating",
                prop = "burger",
                usetime = 1500
            }
        },
        ["g1_4753_churchkey1"] = {
            label = "灰鱷倉庫鑰匙",
            weight = 20,
            stack = true,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_1788_foodcan3"] = {
            label = "橘子罐頭",
            weight = 312,
            stack = true,
            close = true,
            consume = 1,
            description = "",
            client = {
                status = {hunger = 250000, thirst = 80000},
                anim = "eating",
                prop = "burger",
                usetime = 1500
            }
        },
        ["g1_1788_foodcan4"] = {
            label = "番茄糊罐頭",
            weight = 340,
            stack = true,
            close = true,
            consume = 1,
            description = "",
            client = {
                status = {hunger = 250000},
                anim = "eating",
                prop = "burger",
                usetime = 1500
            }
        },
        ["g1_8743_threecupmushroom"] = {
            label = "三杯杏鮑菇",
            weight = 250,
            stack = false,
            close = true,
            consume = 1,
            description = "",
            client = {
                status = {hunger = 200000},
                anim = "eating",
                prop = "burger",
                usetime = 1500,
                notification = ""
            }
        },
        ["alive_chicken"] = {
            label = "Living chicken",
            weight = 1,
            stack = true,
            close = true,
        },
        ["bandage"] = {
            label = "Bandage",
            weight = 2,
            stack = true,
            close = true,
        },
        ["blowpipe"] = {
            label = "Blowtorch",
            weight = 2,
            stack = true,
            close = true,
        },
        ["bread"] = {
            label = "Bread",
            weight = 1,
            stack = true,
            close = true,
        },
        ["cannabis"] = {
            label = "Cannabis",
            weight = 3,
            stack = true,
            close = true,
        },
        ["carokit"] = {
            label = "Body Kit",
            weight = 3,
            stack = true,
            close = true,
        },
        ["carotool"] = {
            label = "Tools",
            weight = 2,
            stack = true,
            close = true,
        },
        ["clothe"] = {
            label = "Cloth",
            weight = 1,
            stack = true,
            close = true,
        },
        ["copper"] = {
            label = "Copper",
            weight = 1,
            stack = true,
            close = true,
        },
        ["cutted_wood"] = {
            label = "Cut wood",
            weight = 1,
            stack = true,
            close = true,
        },
        ["diamond"] = {
            label = "Diamond",
            weight = 1,
            stack = true,
            close = true,
        },
        ["essence"] = {
            label = "Gas",
            weight = 1,
            stack = true,
            close = true,
        },
        ["fabric"] = {
            label = "Fabric",
            weight = 1,
            stack = true,
            close = true,
        },
        ["fish"] = {
            label = "Fish",
            weight = 1,
            stack = true,
            close = true,
        },
        ["fixkit"] = {
            label = "Repair Kit",
            weight = 3,
            stack = true,
            close = true,
        },
        ["fixtool"] = {
            label = "Repair Tools",
            weight = 2,
            stack = true,
            close = true,
        },
        ["gazbottle"] = {
            label = "Gas Bottle",
            weight = 2,
            stack = true,
            close = true,
        },
        ["gold"] = {
            label = "Gold",
            weight = 1,
            stack = true,
            close = true,
        },
        ["iron"] = {
            label = "Iron",
            weight = 1,
            stack = true,
            close = true,
        },
        ["marijuana"] = {
            label = "Marijuana",
            weight = 2,
            stack = true,
            close = true,
        },
        ["medikit"] = {
            label = "Medikit",
            weight = 2,
            stack = true,
            close = true,
        },
        ["packaged_chicken"] = {
            label = "Chicken fillet",
            weight = 1,
            stack = true,
            close = true,
        },
        ["packaged_plank"] = {
            label = "Packaged wood",
            weight = 1,
            stack = true,
            close = true,
        },
        ["petrol"] = {
            label = "Oil",
            weight = 1,
            stack = true,
            close = true,
        },
        ["petrol_raffin"] = {
            label = "Processed oil",
            weight = 1,
            stack = true,
            close = true,
        },
        ["slaughtered_chicken"] = {
            label = "Slaughtered chicken",
            weight = 1,
            stack = true,
            close = true,
        },
        ["stone"] = {
            label = "Stone",
            weight = 1,
            stack = true,
            close = true,
        },
        ["washed_stone"] = {
            label = "Washed stone",
            weight = 1,
            stack = true,
            close = true,
        },
        ["water"] = {
            label = "Water",
            weight = 1,
            stack = true,
            close = true,
        },
        ["wood"] = {
            label = "Wood",
            weight = 1,
            stack = true,
            close = true,
        },
        ["wool"] = {
            label = "Wool",
            weight = 1,
            stack = true,
            close = true,
        },
}