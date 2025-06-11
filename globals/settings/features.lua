-------------------------------------------------------------------------------
	local UIFactory = UIFactory
	local settings = _G.enemyFramesSettings
	local container = _G.enemyFramesSettingsfeaturesContainer
	-------------------------------------------------------------------------------
	local checkBoxFeaturesN, checkBoxFeatures  = 6, { 	--[1] = {['id'] = 'enableOutdoors', 		['label'] = 'Enable outside of BattleGrounds'},
														[1] = {['id'] = 'mouseOver', 			['label'] = 'Mouseover cast on frames'},	
														[2] = {['id'] = 'targetFrameCastbar', 	['label'] = 'Moveable Target Cast Bar'},														
														[3] = {['id'] = 'integratedTargetFrameCastbar', 	['label'] = 'Integrated Target Cast Bar'},
														[4] = {['id'] = 'targetPortraitDebuff', ['label'] = 'Prio debuff on Target Portrait'},
														[5] = {['id'] = 'playerPortraitDebuff', ['label'] = 'Prio debuff on Player Portrait'},
														[6] = {['id'] = 'targetDebuffTimers', 	['label'] = 'Debuff timers on target'},
														
													}
	local checkBoxFeaturesBGN, checkBoxFeaturesBG  = 3, {	[1] = {['id'] = 'incomingSpells', 		['label'] = 'Incoming Spells (BGs only)'},
															[2] = {['id'] = 'pvpmapblips', 			['label'] = 'Class colored map blips'},
															[3] = {['id'] = 'efcBGannouncement', 	['label'] = 'Low Health EFC announcement'},
															
														}
	-------------------------------------------------------------------------------
	-- features
	container.features = container:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
	container.features:SetPoint('LEFT', container, 'TOPLEFT', 45, -30)
	container.features:SetText'features'

	container.featuresList = {}
	for i = 1, checkBoxFeaturesN, 1 do
		local color = RGB_FACTION_COLORS['Alliance']
		container.featuresList[i] = UIFactory.CheckBox(container, 45, -30 - (i-1) * 30,
			checkBoxFeatures[i]['id'], checkBoxFeatures[i]['label'], color,
			function(v) ENEMYFRAMESPLAYERDATA[checkBoxFeatures[i]['id']] = v; ENEMYFRAMESsettings() end)
	end
	-------------------------------------------------------------------------------
	container.bgLabel = container:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
	container.bgLabel:SetPoint('LEFT', container.featuresList[checkBoxFeaturesN], 'LEFT', 0, -30)
	container.bgLabel:SetText'battlegrounds'
	
	container.bgList = {}
	for i = 1, checkBoxFeaturesBGN, 1 do
		local color = RGB_FACTION_COLORS['Alliance']
		container.bgList[i] = UIFactory.CheckBox(container, 45, -30 - (i-1) * 30,
			checkBoxFeaturesBG[i]['id'], checkBoxFeaturesBG[i]['label'], color,
			function(v) 
				ENEMYFRAMESPLAYERDATA[checkBoxFeaturesBG[i]['id']] = v
				ENEMYFRAMESsettings() 
				INCOMINGSPELLSsettings(ENEMYFRAMESPLAYERDATA['incomingSpells']) 
			end)
	end
	
	-------------------------------------------------------------------------------
	FEATURESSETTINGSInit = function(color)
		for i = 1, checkBoxFeaturesN do
			container.featuresList[i]:SetChecked(ENEMYFRAMESPLAYERDATA[checkBoxFeatures[i]['id']])
		end
		
		for i = 1, checkBoxFeaturesBGN do
			container.bgList[i]:SetChecked(ENEMYFRAMESPLAYERDATA[checkBoxFeaturesBG[i]['id']])
		end
		
		-- disable incoming spells for rogues
		local _, c = UnitClass'player'
		if c == 'ROGUE' then 	ENEMYFRAMESPLAYERDATA['incomingSpells'] = false 
								container.bgList[1]:Disable()  
								_G[container.bgList[1]:GetName()..'Text']:SetTextColor(.5, .5, .5, .9)								
		end
	end
	-------------------------------------------------------------------------------