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
            label = " ",
             --'特效晶片卡',
            weight = 20,
            stack = true,
            close = true,
            consume = 1,
            description = "卡片上寫著一行字：特效微型晶片卡"
        },
        ["whalepic_abilitycard"] = {
            label = " ",
             --'能力晶片卡',
            weight = 20,
            stack = true,
            close = true,
            consume = 1,
            description = "卡片上寫著一行字：訓練微型晶片卡"
        },
        ["whalepic_specialcard"] = {
            label = " ",
             --'特殊晶片卡',
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
            label = " ",
             --'Test Burger',
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
            label = " ",
             --'xxx',
            weight = 23,
            stack = 1,
            close = 1,
            description = ""
        },
        ["W1-1"] = {
            label = " ",
             --'煙火筒',
            weight = 50,
            stack = 1,
            close = 1,
            description = "煙火筒",
            client = {
                usetime = 2500
            }
        },
        ["jingxaingflower"] = {
            label = " ",
             --'璟湘花',
            weight = 21,
            stack = 1,
            close = 1,
            description = ""
        },
        ["medicinepackage_double"] = {
            label = " ",
             --'特效藥',
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
            label = " ",
             --'金屬探測器',
            weight = 1500,
            stack = 1,
            close = 1,
            description = "金屬探測器"
        },
        ["shock_absorber"] = {
            label = " ",
             --'荊棘草',
            weight = 100,
            stack = true,
            close = true
        },
        ["garett"] = {
            label = " ",
             --'荊棘草',
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
            label = " ",
             --'荊棘草',
            weight = 100,
            stack = true,
            close = true
        },
        ["rod"] = {
            label = " ",
             --'荊棘草',
            weight = 100,
            stack = true,
            close = true
        },
        ["gear"] = {
            label = " ",
             --'荊棘草',
            weight = 100,
            stack = true,
            close = true
        },
        ["aluminum"] = {
            label = " ",
             --'荊棘草',
            weight = 100,
            stack = true,
            close = true
        },
        ["brake_discs"] = {
            label = " ",
             --'荊棘草',
            weight = 100,
            stack = true,
            close = true
        },
        ["brake_caliper"] = {
            label = " ",
             --'荊棘草',
            weight = 100,
            stack = true,
            close = true
        },
        ["shock_absorber"] = {
            label = " ",
             --'荊棘草',
            weight = 100,
            stack = true,
            close = true
        },
        ["springs"] = {
            label = " ",
             --'荊棘草',
            weight = 100,
            stack = true,
            close = true
        },
        ["golf"] = {
            label = " ",
             --'高爾夫球(白)',
            weight = 10,
            stack = true,
            close = true,
            consume = 0,
            client = {
                usetime = 0
            }
        },
        ["golf_yellow"] = {
            label = " ",
             --'高爾夫球(黃)',
            weight = 10,
            stack = true,
            close = true,
            client = {
                usetime = 0
            }
        },
        ["golf_green"] = {
            label = " ",
             --'高爾夫球(綠)',
            weight = 10,
            stack = true,
            close = true,
            client = {
                usetime = 0
            }
        },
        ["golf_pink"] = {
            label = " ",
             --'高爾夫球(粉)',
            weight = 10,
            stack = true,
            close = true,
            client = {
                usetime = 0
            }
        },
        ["blk"] = {
            label = " ",
             --'巴洛克家徽',
            weight = 50,
            stack = true,
            close = true
        },
        ["rtjuice"] = {
            label = " ",
             --'阿天果汁',
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
            label = " ",
             --'米漿',
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
            label = " ",
             --'費氏特效小藥包',
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
            label = " ",
             --'身分證',
            weight = 0,
            stack = true,
            close = true
        },
        ["ve_matral"] = {
            label = " ",
             --'載具材料',
            weight = 400,
            stack = true,
            close = true
        },
        ["shineshell"] = {
            label = " ",
             --'晶貝',
            weight = 150,
            stack = true,
            close = true,
            description = "製成亮鯨金的原料，可高價出售給契拉家。"
        },
        ["seasalt"] = {
            label = " ",
             --'海岩鹽',
            weight = 11,
            stack = true,
            close = true,
            description = "附著在海岸的礦物的鹽份，與礦物本身的物質結合，形成特別的海岩鹽。"
        },
        ["prop_bones"] = {
            label = " ",
             --'骨頭',
            weight = 150,
            stack = true,
            close = true
        },
        ["prop_dragon_scales"] = {
            label = " ",
             --'特殊鱗片',
            weight = 100,
            stack = true,
            close = true
        },
        ["prop_metalscrap"] = {
            label = " ",
             --'金屬廢料',
            weight = 150,
            stack = true,
            close = true
        },
        ["prop_nuts_and_bolts"] = {
            label = " ",
             --'螺母和螺栓',
            weight = 150,
            stack = true,
            close = true
        },
        ["petroleum"] = {
            label = " ",
             --'原油',
            weight = 80,
            stack = true,
            close = true
        },
        ["fixed"] = {
            label = " ",
             --'固定器',
            weight = 600,
            stack = true,
            close = true
        },
        ["custom_pack"] = {
            label = " ",
             --'改車包',
            weight = 250,
            stack = true,
            close = true
        },
        ["coffeebeans"] = {
            label = " ",
             --'咖啡豆',
            weight = 75,
            stack = true,
            close = true,
            description = "咖啡豆"
        },
        ["cryfruit"] = {
            label = " ",
             --'鯨淚果',
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
            label = " ",
             --'肉',
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
            label = " ",
             --'阿天果',
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
            label = " ",
             --'石英',
            weight = 50,
            stack = true,
            close = true
        },
        ["score8"] = {
            label = " ",
             --'分數八',
            weight = 0,
            stack = true
        },
        ["rake"] = {
            label = " ",
             --'扒子',
            weight = 100,
            stack = 0,
            close = 1,
            description = ""
        },
        ["green_melon"] = {
            label = " ",
             --'史蒂尼綠黃瓜碳酸飲料',
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
            label = " ",
             --'史班尼紅蘋果碳酸飲料',
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
            label = " ",
             --'史齊尼黃梨子碳酸飲料',
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
            label = " ",
             --'光與影-康×管同人本',
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
            label = " ",
             --'沈老師的回憶',
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
            label = " ",
             --'混一步燒肉飯',
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
            label = " ",
             --'檸檬汁',
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
            label = " ",
             --'蔓越莓司康',
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
            label = " ",
             --'檸檬馬鞭草茶',
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
            label = " ",
             --'野格',
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
            label = " ",
             --'取血針',
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
            label = " ",
             --'烤鹿排',
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
            label = " ",
             --'壽司',
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
            label = " ",
             --'報紙0206-0210',
            weight = 50,
            stack = true,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["lulu_cardbrown"] = {
            label = " ",
             -- '布朗妮簽名小卡',
            weight = 100,
            stack = true,
            close = true,
            consume = 0,
            description = "上面印有布朗妮娃娃圖樣的小卡片，可以用來簽名。卡片背後有一行小字。",
            client = {}
        },
        ["bear_bearcupcake"] = {
            label = " ",
             -- '小熊杯子蛋糕',
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
            label = " ",
             -- '桂圓紅棗湯',
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
            label = " ",
             -- 'logo',
            weight = 5,
            stack = true,
            close = true,
            consume = 0
        },
        ["g1_needle_holder"] = {
            label = " ",
             -- '持針器',
            weight = 50,
            stack = false,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_oilcan"] = {
            label = " ",
             -- '汽油桶',
            weight = 1000,
            stack = false,
            close = true,
            consume = 1,
            description = "",
            client = {}
        },
        ["g1_toothpaste"] = {
            label = " ",
             -- '牙膏',
            weight = 150,
            stack = false,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_opener2"] = {
            label = " ",
             -- '開瓶器',
            weight = 150,
            stack = false,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_body_1"] = {
            label = " ",
             -- '斷肢1',
            weight = 50,
            stack = true,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_body_2"] = {
            label = " ",
             -- '斷肢2',
            weight = 100,
            stack = true,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_body_3"] = {
            label = " ",
             -- '斷肢3',
            weight = 350,
            stack = false,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_body_4"] = {
            label = " ",
             -- '斷肢4',
            weight = 450,
            stack = false,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_body_5"] = {
            label = " ",
             -- '斷肢5',
            weight = 350,
            stack = false,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_strawmachi"] = {
            label = " ",
             -- '草莓麻糬',
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
            label = " ",
             -- '一公升軍用水壺(空)',
            weight = 15,
            stack = false,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_3931_blanket"] = {
            label = " ",
             -- '法蘭絨單人毛毯',
            weight = 650,
            stack = false,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_5938_food1"] = {
            label = " ",
             -- '醃肉罐',
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
            label = " ",
             -- '水果乾',
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
            label = " ",
             -- '畫冊',
            weight = 1600,
            stack = false,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_1miao"] = {
            label = " ",
             -- '疫苗',
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
            label = " ",
             -- '香煎雞胸肉',
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
            label = " ",
             -- '生魚片',
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
            label = " ",
             -- '灰鱷倉庫鑰匙',
            weight = 20,
            stack = true,
            close = true,
            consume = 0,
            description = "",
            client = {}
        },
        ["g1_1788_foodcan3"] = {
            label = " ",
             -- '橘子罐頭',
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
            label = " ",
             -- '番茄糊罐頭',
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
            label = " ",
             -- '三杯杏鮑菇',
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