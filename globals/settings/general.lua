-------------------------------------------------------------------------------
	local settings = _G['enemyFramesSettings']
	
	local container = CreateFrame('Frame', 'enemyFramesSettingsgeneralContainer', settings)
	container:SetWidth(settings:GetWidth()) container:SetHeight(settings:GetHeight())
	container:SetPoint('CENTER', settings)
	container:EnableMouse(true)
	container:EnableMouseWheel(true)
	container:Hide()
	-------------------------------------------------------------------------------
	local checkBoxGeneralN, checkBoxGeneral  = 1, { 	[1] = {['id'] = 'enableFrames', 		['label'] = 'Show enemyFrames'},
													}
	-------------------------------------------------------------------------------
	-- general checkbox
	container.generalList = {}
	for i = 1, checkBoxGeneralN, 1 do
		container.generalList[i] = CreateFrame('CheckButton', 'enemyFramesGeneralCheckButton'..i, container, 'UICheckButtonTemplate')
		container.generalList[i]:SetHeight(20) 	container.generalList[i]:SetWidth(20)
		if i == 1 then
			container.generalList[i]:SetPoint('LEFT', container, 'TOPLEFT', 45, -30)
		else
			container.generalList[i]:SetPoint('LEFT', container.generalList[i-1], 'LEFT', 0, -30)
		end
		_G[container.generalList[i]:GetName()..'Text']:SetText(checkBoxGeneral[i]['label'])
		_G[container.generalList[i]:GetName()..'Text']:SetPoint('LEFT', container.generalList[i], 'RIGHT', 4, 0)
		container.generalList[i].id = checkBoxGeneral[i]['id']
		container.generalList[i]:SetScript('OnClick', function()
			ENEMYFRAMESPLAYERDATA[this.id] = this:GetChecked()
			ENEMYFRAMESsettings()
		end)
	end
	
	-- scale
	container.scale = container:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
	container.scale:SetPoint('LEFT', container.generalList[checkBoxGeneralN], 'LEFT', 0, -30)
	container.scale:SetText'scale'

	container.scaleSlider = CreateFrame('Slider', 'enemyFramesScaleSlider', container, 'OptionsSliderTemplate')
	container.scaleSlider:SetWidth(215) 	container.scaleSlider:SetHeight(14)
	container.scaleSlider:SetPoint('LEFT', container.scale, 'LEFT', 0, -30)
	container.scaleSlider:SetMinMaxValues(0.8, 1.5)
	container.scaleSlider:SetValueStep(.05)
	_G[container.scaleSlider:GetName()..'Low']:SetText'0.8'
	_G[container.scaleSlider:GetName()..'High']:SetText'1.5'


	container.scaleSlider:SetScript('OnValueChanged', function() 
		ENEMYFRAMESPLAYERDATA['scale'] = this:GetValue() 
		_G['enemyFrameDisplay']:SetScale(ENEMYFRAMESPLAYERDATA['scale'])
	end)

	-- layout

	container.layout = container:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
	container.layout:SetPoint('LEFT', container.scaleSlider, 'LEFT', 0, -50)
	container.layout:SetText'layout'

	container.layoutSlider = CreateFrame('Slider', 'enemyFramesLayoutSlider', container, 'OptionsSliderTemplate')
	container.layoutSlider:SetWidth(215) 	container.layoutSlider:SetHeight(14)
	container.layoutSlider:SetPoint('LEFT', container.layout, 'LEFT', 0, -30)
	container.layoutSlider:SetMinMaxValues(0, 4)
	container.layoutSlider:SetValueStep(1)
	_G[container.layoutSlider:GetName()..'Low']:SetText'horizontal'
	_G[container.layoutSlider:GetName()..'High']:SetText'vertical'


	container.layoutSlider:SetScript('OnValueChanged', function() 
		local v = this:GetValue()
		local a = v == 0 and 'horizontal' or v == 1 and 'hblock' or v == 2 and 'block' or v == 3 and 'vblock' or 'vertical'
		local g = v == 0 and 1 or (v == 1 or v == 2) and 5 or v == 3 and 2 or 15
		ENEMYFRAMESPLAYERDATA['layout'] 	= a
		ENEMYFRAMESPLAYERDATA['groupsize']  = g
		ENEMYFRAMESsettings()
	end)
	
	
	-- version
	container.version = container:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
	container.version:SetPoint('LEFT', container.layoutSlider, 'LEFT', 0, -80)
	container.version:SetJustifyH('LEFT')
	container.version:SetTextColor(1, 1, 1)
	container.version:SetText('enemyFrames by kuurtz \nver - |cffffff00' .. ENEMYFRAMESVERSION)
	
	container.forumlink = CreateFrame('EditBox', 'enemyFrame_forumlink', container, 'InputBoxTemplate')
    container.forumlink:SetFont(STANDARD_TEXT_FONT, 12)
    container.forumlink:SetWidth(240) container.forumlink:SetHeight(10)
	container.forumlink:SetPoint('TOPLEFT', container.version, 'BOTTOMLEFT', 0, -15)
    container.forumlink:SetAutoFocus(false)
    
	
	container.newversion = container:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
	container.newversion:SetPoint('BOTTOMLEFT', container.version, 'TOP', -10, 5)	
	container.newversion:Hide()
	
	container.forumlink:SetScript('OnShow', function()
        this:SetText'https://github.com/zetone/enemyFrames'
		
		if ENEMYFRAMESVERSIONFOUND then
			container.newversion:SetText('|cffffff00( !ver '..ENEMYFRAMESNEWVERSION..' available! )')
			container.newversion:Show()
		end
    end)
	
	-------------------------------------------------------------------------------
	GENERALSSETTINGSInit = function(color)
		_G[container.scaleSlider:GetName()..'Low']:SetTextColor(color['r'], color['g'], color['b'], .9)
		_G[container.scaleSlider:GetName()..'High']:SetTextColor(color['r'], color['g'], color['b'], .9)
		_G[container.layoutSlider:GetName()..'Low']:SetTextColor(color['r'], color['g'], color['b'], .9)
		_G[container.layoutSlider:GetName()..'High']:SetTextColor(color['r'], color['g'], color['b'], .9)
		
		for i = 1, checkBoxGeneralN, 1 do
			_G[container.generalList[i]:GetName()..'Text']:SetTextColor(color['r'], color['g'], color['b'], .9)
			container.generalList[i]:SetChecked(ENEMYFRAMESPLAYERDATA[checkBoxGeneral[i]['id']])
		end
		
		container.scaleSlider:SetValue(ENEMYFRAMESPLAYERDATA['scale'])
		container.layoutSlider:SetValue(ENEMYFRAMESPLAYERDATA['layout'] == 'horizontal' and 0 or ENEMYFRAMESPLAYERDATA['layout'] == 'hblock' and 1 or ENEMYFRAMESPLAYERDATA['layout'] == 'block' and 2 or ENEMYFRAMESPLAYERDATA['layout'] == 'vblock' and 3 or 4)
		
		--container.newversion:SetTextColor(color['r'], color['g'], color['b'], .9)
	end
	-------------------------------------------------------------------------------
	local UIFactory = UIFactory
	local settings = _G.enemyFramesSettings
	local container = _G.enemyFramesSettingsgeneralContainer
	-- remove the existing CreateFrame+Manual positioning...

	-- instead, do:
	local color = RGB_FACTION_COLORS['Alliance'] -- will be updated on setupSettings
	local cbEnable = UIFactory.CheckBox(container, 45, -30,
	    'enableFrames', 'Show enemyFrames', color,
	    function(v) ENEMYFRAMESPLAYERDATA.enableFrames = v; ENEMYFRAMESsettings() end)

	local sliderScale = UIFactory.Slider(container, 45, -70,
	    '0.8', '1.5', .8, 1.5, .05, color,
	    function(v) ENEMYFRAMESPLAYERDATA.scale = v; _G.enemyFrameDisplay:SetScale(v) end)

	-- layout slider (example):
	local sliderLayout = UIFactory.Slider(container, 45, -110,
	    'horizontal','vertical', 0, 4, 1, color,
	    function(v)
	        local a = ({'horizontal','hblock','block','vblock','vertical'})[v+1]
	        local g = ({1,5,5,2,15})[v+1]
	        ENEMYFRAMESPLAYERDATA.layout = a
	        ENEMYFRAMESPLAYERDATA.groupsize = g
	        ENEMYFRAMESsettings()
	    end)