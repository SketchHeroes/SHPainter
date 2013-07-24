package 
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.IStyleManager2;
   import mx.managers.systemClasses.ChildManager;
   import mx.styles.StyleManagerImpl;
   import mx.effects.EffectManager;
   import mx.core.mx_internal;
   import mx.accessibility.ListAccImpl;
   import mx.accessibility.AlertAccImpl;
   import mx.accessibility.ComboBoxAccImpl;
   import mx.accessibility.ColorPickerAccImpl;
   import mx.accessibility.LabelAccImpl;
   import mx.accessibility.PanelAccImpl;
   import mx.accessibility.SliderAccImpl;
   import mx.accessibility.ListBaseAccImpl;
   import mx.accessibility.CheckBoxAccImpl;
   import mx.accessibility.ButtonAccImpl;
   import mx.accessibility.ComboBaseAccImpl;
   import mx.accessibility.UIComponentAccProps;
   import flash.net.getClassByAlias;
   import mx.collections.ArrayCollection;
   import flash.net.registerClassAlias;
   import mx.collections.ArrayList;
   import mx.graphics.ImageSnapshot;
   import mx.utils.ObjectProxy;
   import flash.system.*;
   import flash.utils.*;


   public class _SHPainter_FlexInit extends Object
   {
      public function _SHPainter_FlexInit() {
         super();
         return;
      }

      public static function init(param1:IFlexModuleFactory) : void {
         var styleManager:IStyleManager2 = null;
         var fbs:IFlexModuleFactory = param1;
         styleManager=StyleManagerImpl.getInstance();
         fbs.registerImplementation("mx.styles::IStyleManager2",styleManager);
         styleManager.qualifiedTypeSelectors=false;
         EffectManager.mx_internal::registerEffectTrigger("addedEffect","added");
         EffectManager.mx_internal::registerEffectTrigger("completeEffect","complete");
         EffectManager.mx_internal::registerEffectTrigger("creationCompleteEffect","creationComplete");
         EffectManager.mx_internal::registerEffectTrigger("focusInEffect","focusIn");
         EffectManager.mx_internal::registerEffectTrigger("focusOutEffect","focusOut");
         EffectManager.mx_internal::registerEffectTrigger("hideEffect","hide");
         EffectManager.mx_internal::registerEffectTrigger("itemsChangeEffect","itemsChange");
         EffectManager.mx_internal::registerEffectTrigger("mouseDownEffect","mouseDown");
         EffectManager.mx_internal::registerEffectTrigger("mouseUpEffect","mouseUp");
         EffectManager.mx_internal::registerEffectTrigger("moveEffect","move");
         EffectManager.mx_internal::registerEffectTrigger("removedEffect","removed");
         EffectManager.mx_internal::registerEffectTrigger("resizeEffect","resize");
         EffectManager.mx_internal::registerEffectTrigger("resizeEndEffect","resizeEnd");
         EffectManager.mx_internal::registerEffectTrigger("resizeStartEffect","resizeStart");
         EffectManager.mx_internal::registerEffectTrigger("rollOutEffect","rollOut");
         EffectManager.mx_internal::registerEffectTrigger("rollOverEffect","rollOver");
         EffectManager.mx_internal::registerEffectTrigger("showEffect","show");
         if(Capabilities.hasAccessibility)
         {
            ListAccImpl.enableAccessibility();
            AlertAccImpl.enableAccessibility();
            ComboBoxAccImpl.enableAccessibility();
            ColorPickerAccImpl.enableAccessibility();
            LabelAccImpl.enableAccessibility();
            PanelAccImpl.enableAccessibility();
            SliderAccImpl.enableAccessibility();
            ListBaseAccImpl.enableAccessibility();
            CheckBoxAccImpl.enableAccessibility();
            ButtonAccImpl.enableAccessibility();
            ComboBaseAccImpl.enableAccessibility();
            UIComponentAccProps.enableAccessibility();
         }
         try
         {
            if(getClassByAlias("flex.messaging.io.ArrayCollection") != ArrayCollection)
            {
               registerClassAlias("flex.messaging.io.ArrayCollection",ArrayCollection);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.messaging.io.ArrayCollection",ArrayCollection);
         }
         try
         {
            if(getClassByAlias("flex.messaging.io.ArrayList") != ArrayList)
            {
               registerClassAlias("flex.messaging.io.ArrayList",ArrayList);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.messaging.io.ArrayList",ArrayList);
         }
         try
         {
            if(getClassByAlias("flex.graphics.ImageSnapshot") != ImageSnapshot)
            {
               registerClassAlias("flex.graphics.ImageSnapshot",ImageSnapshot);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.graphics.ImageSnapshot",ImageSnapshot);
         }
         try
         {
            if(getClassByAlias("flex.messaging.io.ObjectProxy") != ObjectProxy)
            {
               registerClassAlias("flex.messaging.io.ObjectProxy",ObjectProxy);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.messaging.io.ObjectProxy",ObjectProxy);
         }
         var styleNames:Array = ["highlightColor","kerning","iconColor","showErrorSkin","textRollOverColor","shadowCapColor","textDecoration","showErrorTip","fontThickness","selectionDisabledColor","letterSpacing","chromeColor","rollOverColor","fontSize","shadowColor","fontWeight","leading","symbolColor","fontSharpness","barColor","modalTransparencyDuration","layoutDirection","footerColors","contentBackgroundColor","contentBackgroundAlpha","fontAntiAliasType","direction","errorColor","locale","backgroundDisabledColor","modalTransparencyColor","textIndent","themeColor","modalTransparency","headerColors","textAlign","fontFamily","textSelectedColor","interactionMode","fontGridFitType","fontStyle","dropShadowColor","accentColor","disabledColor","selectionColor","dropdownBorderColor","disabledIconColor","modalTransparencyBlur","focusColor","color","alternatingItemColors"];
         var i:int = 0;
         while(i < styleNames.length)
         {
            styleManager.registerInheritingStyle(styleNames[i]);
            i++;
         }
         return;
      }
   }

}