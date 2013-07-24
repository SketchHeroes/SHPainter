package 
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.IStyleManager2;
   import mx.styles.CSSStyleDeclaration;
   import mx.skins.halo.ApplicationBackground;
   import mx.skins.halo.ButtonSkin;
   import mx.skins.halo.CheckBoxIcon;
   import mx.skins.halo.ColorPickerSkin;
   import mx.skins.halo.ComboBoxArrowSkin;
   import mx.skins.halo.HaloBorder;
   import mx.skins.halo.SliderHighlightSkin;
   import mx.skins.halo.SliderThumbSkin;
   import mx.skins.halo.SliderTrackSkin;
   import mx.skins.halo.ListDropIndicator;
   import mx.skins.halo.TitleBackground;
   import mx.skins.halo.PanelSkin;
   import mx.core.mx_internal;
   import mx.skins.halo.ScrollTrackSkin;
   import mx.skins.halo.ScrollArrowSkin;
   import mx.skins.halo.ScrollThumbSkin;
   import mx.skins.halo.HaloFocusRect;
   import mx.core.UITextField;
   import mx.skins.halo.BusyCursor;
   import mx.skins.halo.DefaultDragImage;
   import mx.skins.halo.BrokenImageBorderSkin;
   import mx.skins.halo.ToolTipBorder;


   public class _SHPainter_Styles extends Object
   {
      public function _SHPainter_Styles() {
         super();
         return;
      }

      private static var _embed_css_Assets_swf_401520661___brokenImage_247155719:Class = _class_embed_css_Assets_swf_401520661___brokenImage_247155719;

      private static var _embed_css_Assets_swf_401520661_mx_skins_cursor_DragLink_1217347310:Class = _class_embed_css_Assets_swf_401520661_mx_skins_cursor_DragLink_1217347310;

      private static var _embed_css_Assets_swf_401520661_mx_skins_cursor_DragReject_270167229:Class = _class_embed_css_Assets_swf_401520661_mx_skins_cursor_DragReject_270167229;

      private static var _embed_css_Assets_swf_401520661_mx_skins_cursor_BusyCursor_898905871:Class = _class_embed_css_Assets_swf_401520661_mx_skins_cursor_BusyCursor_898905871;

      private static var _embed_css_Assets_swf_401520661_mx_skins_cursor_DragCopy_1217085305:Class = _class_embed_css_Assets_swf_401520661_mx_skins_cursor_DragCopy_1217085305;

      private static var _embed_css_Assets_swf_401520661_mx_skins_cursor_DragMove_1217372885:Class = _class_embed_css_Assets_swf_401520661_mx_skins_cursor_DragMove_1217372885;

      public static function init(param1:IFlexModuleFactory) : void {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         var fbs:IFlexModuleFactory = param1;
         var styleManager:IStyleManager2 = fbs.getImplementation("mx.styles::IStyleManager2") as IStyleManager2;
         style=styleManager.getStyleDeclaration(".activeButtonStyle");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".activeButtonStyle",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               return;
            };
         }
         styleManager.setStyleDeclaration(".activeButtonStyle",style,false);
         style=styleManager.getStyleDeclaration(".activeTabStyle");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".activeTabStyle",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.fontWeight="bold";
               return;
            };
         }
         styleManager.setStyleDeclaration(".activeTabStyle",style,false);
         style=styleManager.getStyleDeclaration("Alert");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("Alert",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.paddingTop=2;
               _SHPainter_Styles.borderColor=8821927;
               _SHPainter_Styles.roundedBottomCorners=true;
               _SHPainter_Styles.color=16777215;
               _SHPainter_Styles.buttonStyleName="alertButtonStyle";
               _SHPainter_Styles.backgroundColor=8821927;
               _SHPainter_Styles.borderAlpha=0.9;
               _SHPainter_Styles.paddingLeft=10;
               _SHPainter_Styles.paddingBottom=2;
               _SHPainter_Styles.backgroundAlpha=0.9;
               _SHPainter_Styles.paddingRight=10;
               return;
            };
         }
         styleManager.setStyleDeclaration("Alert",style,false);
         style=styleManager.getStyleDeclaration(".alertButtonStyle");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".alertButtonStyle",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.color=734012;
               return;
            };
         }
         styleManager.setStyleDeclaration(".alertButtonStyle",style,false);
         style=styleManager.getStyleDeclaration("Application");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("Application",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.backgroundSize="100%";
               _SHPainter_Styles.paddingTop=24;
               _SHPainter_Styles.backgroundColor=8821927;
               _SHPainter_Styles.backgroundImage=ApplicationBackground;
               _SHPainter_Styles.horizontalAlign="center";
               _SHPainter_Styles.backgroundGradientAlphas=[1,1];
               _SHPainter_Styles.paddingLeft=24;
               _SHPainter_Styles.paddingBottom=24;
               _SHPainter_Styles.paddingRight=24;
               return;
            };
         }
         styleManager.setStyleDeclaration("Application",style,false);
         style=styleManager.getStyleDeclaration("Button");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("Button",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.fontWeight="bold";
               _SHPainter_Styles.paddingTop=2;
               _SHPainter_Styles.cornerRadius=4;
               _SHPainter_Styles.labelVerticalOffset=0;
               _SHPainter_Styles.textAlign="center";
               _SHPainter_Styles.emphasizedSkin=null;
               _SHPainter_Styles.verticalGap=2;
               _SHPainter_Styles.horizontalGap=2;
               _SHPainter_Styles.skin=ButtonSkin;
               _SHPainter_Styles.paddingLeft=10;
               _SHPainter_Styles.paddingBottom=2;
               _SHPainter_Styles.paddingRight=10;
               return;
            };
         }
         styleManager.setStyleDeclaration("Button",style,false);
         style=styleManager.getStyleDeclaration("CheckBox");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("CheckBox",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.downSkin=null;
               _SHPainter_Styles.iconColor=2831164;
               _SHPainter_Styles.selectedDownIcon=null;
               _SHPainter_Styles.selectedUpSkin=null;
               _SHPainter_Styles.overIcon=null;
               _SHPainter_Styles.skin=null;
               _SHPainter_Styles.upSkin=null;
               _SHPainter_Styles.selectedDownSkin=null;
               _SHPainter_Styles.selectedOverIcon=null;
               _SHPainter_Styles.selectedDisabledIcon=null;
               _SHPainter_Styles.textAlign="left";
               _SHPainter_Styles.horizontalGap=5;
               _SHPainter_Styles.paddingBottom=2;
               _SHPainter_Styles.downIcon=null;
               _SHPainter_Styles.icon=CheckBoxIcon;
               _SHPainter_Styles.overSkin=null;
               _SHPainter_Styles.paddingTop=2;
               _SHPainter_Styles.disabledIcon=null;
               _SHPainter_Styles.selectedDisabledSkin=null;
               _SHPainter_Styles.upIcon=null;
               _SHPainter_Styles.paddingLeft=0;
               _SHPainter_Styles.paddingRight=0;
               _SHPainter_Styles.fontWeight="normal";
               _SHPainter_Styles.selectedUpIcon=null;
               _SHPainter_Styles.labelVerticalOffset=0;
               _SHPainter_Styles.disabledSkin=null;
               _SHPainter_Styles.selectedOverSkin=null;
               return;
            };
         }
         styleManager.setStyleDeclaration("CheckBox",style,false);
         style=styleManager.getStyleDeclaration("ColorPicker");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("ColorPicker",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.iconColor=0;
               _SHPainter_Styles.fontSize=11;
               _SHPainter_Styles.verticalGap=0;
               _SHPainter_Styles.shadowColor=5068126;
               _SHPainter_Styles.skin=ColorPickerSkin;
               _SHPainter_Styles.swatchBorderSize=0;
               return;
            };
         }
         styleManager.setStyleDeclaration("ColorPicker",style,false);
         style=styleManager.getStyleDeclaration("ComboBox");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("ComboBox",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.fontWeight="bold";
               _SHPainter_Styles.disabledIconColor=9542041;
               _SHPainter_Styles.paddingTop=0;
               _SHPainter_Styles.dropdownStyleName="comboDropdown";
               _SHPainter_Styles.leading=0;
               _SHPainter_Styles.arrowButtonWidth=22;
               _SHPainter_Styles.cornerRadius=5;
               _SHPainter_Styles.editableSkin=null;
               _SHPainter_Styles.paddingBottom=0;
               _SHPainter_Styles.skin=ComboBoxArrowSkin;
               _SHPainter_Styles.paddingLeft=5;
               _SHPainter_Styles.paddingRight=5;
               return;
            };
         }
         styleManager.setStyleDeclaration("ComboBox",style,false);
         style=styleManager.getStyleDeclaration(".comboDropdown");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".comboDropdown",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.shadowDirection="center";
               _SHPainter_Styles.fontWeight="normal";
               _SHPainter_Styles.dropShadowEnabled=true;
               _SHPainter_Styles.leading=0;
               _SHPainter_Styles.backgroundColor=16777215;
               _SHPainter_Styles.shadowDistance=1;
               _SHPainter_Styles.cornerRadius=0;
               _SHPainter_Styles.borderThickness=0;
               _SHPainter_Styles.paddingLeft=5;
               _SHPainter_Styles.paddingRight=5;
               return;
            };
         }
         styleManager.setStyleDeclaration(".comboDropdown",style,false);
         style=styleManager.getStyleDeclaration("Container");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("Container",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.borderStyle="none";
               _SHPainter_Styles.borderSkin=HaloBorder;
               return;
            };
         }
         styleManager.setStyleDeclaration("Container",style,false);
         style=styleManager.getStyleDeclaration("ControlBar");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("ControlBar",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.disabledOverlayAlpha=0;
               _SHPainter_Styles.borderStyle="controlBar";
               _SHPainter_Styles.paddingTop=10;
               _SHPainter_Styles.verticalAlign="middle";
               _SHPainter_Styles.paddingLeft=10;
               _SHPainter_Styles.paddingBottom=10;
               _SHPainter_Styles.paddingRight=10;
               return;
            };
         }
         styleManager.setStyleDeclaration("ControlBar",style,false);
         style=styleManager.getStyleDeclaration(".dataGridStyles");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".dataGridStyles",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.fontWeight="bold";
               return;
            };
         }
         styleManager.setStyleDeclaration(".dataGridStyles",style,false);
         style=styleManager.getStyleDeclaration(".dateFieldPopup");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".dateFieldPopup",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.dropShadowEnabled=true;
               _SHPainter_Styles.backgroundColor=16777215;
               _SHPainter_Styles.borderThickness=0;
               return;
            };
         }
         styleManager.setStyleDeclaration(".dateFieldPopup",style,false);
         style=styleManager.getStyleDeclaration(".headerDateText");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".headerDateText",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.fontWeight="bold";
               _SHPainter_Styles.textAlign="center";
               return;
            };
         }
         styleManager.setStyleDeclaration(".headerDateText",style,false);
         style=styleManager.getStyleDeclaration(".headerDragProxyStyle");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".headerDragProxyStyle",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.fontWeight="bold";
               return;
            };
         }
         styleManager.setStyleDeclaration(".headerDragProxyStyle",style,false);
         style=styleManager.getStyleDeclaration("HSlider");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("HSlider",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.borderColor=9542041;
               _SHPainter_Styles.tickColor=7305079;
               _SHPainter_Styles.trackHighlightSkin=SliderHighlightSkin;
               _SHPainter_Styles.tickThickness=1;
               _SHPainter_Styles.showTrackHighlight=false;
               _SHPainter_Styles.thumbSkin=SliderThumbSkin;
               _SHPainter_Styles.tickLength=4;
               _SHPainter_Styles.thumbOffset=0;
               _SHPainter_Styles.slideDuration=300;
               _SHPainter_Styles.trackColors=[15198183,15198183];
               _SHPainter_Styles.labelOffset=-10;
               _SHPainter_Styles.dataTipOffset=16;
               _SHPainter_Styles.trackSkin=SliderTrackSkin;
               _SHPainter_Styles.dataTipPrecision=2;
               _SHPainter_Styles.dataTipPlacement="top";
               _SHPainter_Styles.tickOffset=-6;
               return;
            };
         }
         styleManager.setStyleDeclaration("HSlider",style,false);
         style=styleManager.getStyleDeclaration(".linkButtonStyle");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".linkButtonStyle",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.paddingTop=2;
               _SHPainter_Styles.paddingLeft=2;
               _SHPainter_Styles.paddingBottom=2;
               _SHPainter_Styles.paddingRight=2;
               return;
            };
         }
         styleManager.setStyleDeclaration(".linkButtonStyle",style,false);
         style=styleManager.getStyleDeclaration("ListBase");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("ListBase",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.borderStyle="solid";
               _SHPainter_Styles.paddingTop=2;
               _SHPainter_Styles.backgroundColor=16777215;
               _SHPainter_Styles.backgroundDisabledColor=14540253;
               _SHPainter_Styles.dropIndicatorSkin=ListDropIndicator;
               _SHPainter_Styles.paddingLeft=2;
               _SHPainter_Styles.paddingBottom=2;
               _SHPainter_Styles.paddingRight=0;
               return;
            };
         }
         styleManager.setStyleDeclaration("ListBase",style,false);
         style=styleManager.getStyleDeclaration(".opaquePanel");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".opaquePanel",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.borderColor=16777215;
               _SHPainter_Styles.backgroundColor=16777215;
               _SHPainter_Styles.headerColors=[15198183,14277081];
               _SHPainter_Styles.footerColors=[15198183,13092807];
               _SHPainter_Styles.borderAlpha=1;
               return;
            };
         }
         styleManager.setStyleDeclaration(".opaquePanel",style,false);
         style=styleManager.getStyleDeclaration("Panel");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("Panel",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.statusStyleName="windowStatus";
               _SHPainter_Styles.borderStyle="default";
               _SHPainter_Styles.paddingTop=0;
               _SHPainter_Styles.borderColor=14869218;
               _SHPainter_Styles.backgroundColor=16777215;
               _SHPainter_Styles.cornerRadius=4;
               _SHPainter_Styles.titleBackgroundSkin=TitleBackground;
               _SHPainter_Styles.borderAlpha=0.4;
               _SHPainter_Styles.borderThicknessTop=2;
               _SHPainter_Styles.paddingLeft=0;
               _SHPainter_Styles.resizeEndEffect="Dissolve";
               _SHPainter_Styles.paddingRight=0;
               _SHPainter_Styles.titleStyleName="windowStyles";
               _SHPainter_Styles.roundedBottomCorners=false;
               _SHPainter_Styles.borderThicknessRight=10;
               _SHPainter_Styles.dropShadowEnabled=true;
               _SHPainter_Styles.resizeStartEffect="Dissolve";
               _SHPainter_Styles.borderSkin=PanelSkin;
               _SHPainter_Styles.borderThickness=0;
               _SHPainter_Styles.borderThicknessLeft=10;
               _SHPainter_Styles.paddingBottom=0;
               return;
            };
         }
         effects=style.mx_internal::effects;
         if(!effects)
         {
            effects=style.mx_internal::effects=[];
         }
         effects.push("resizeEndEffect");
         effects.push("resizeStartEffect");
         effects.push("resizeEndEffect");
         effects.push("resizeStartEffect");
         styleManager.setStyleDeclaration("Panel",style,false);
         style=styleManager.getStyleDeclaration(".plain");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".plain",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.paddingTop=0;
               _SHPainter_Styles.backgroundColor=16777215;
               _SHPainter_Styles.backgroundImage="";
               _SHPainter_Styles.horizontalAlign="left";
               _SHPainter_Styles.paddingLeft=0;
               _SHPainter_Styles.paddingBottom=0;
               _SHPainter_Styles.paddingRight=0;
               return;
            };
         }
         styleManager.setStyleDeclaration(".plain",style,false);
         style=styleManager.getStyleDeclaration(".popUpMenu");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".popUpMenu",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.fontWeight="normal";
               _SHPainter_Styles.textAlign="left";
               return;
            };
         }
         styleManager.setStyleDeclaration(".popUpMenu",style,false);
         style=styleManager.getStyleDeclaration(".richTextEditorTextAreaStyle");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".richTextEditorTextAreaStyle",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               return;
            };
         }
         styleManager.setStyleDeclaration(".richTextEditorTextAreaStyle",style,false);
         style=styleManager.getStyleDeclaration("ScrollBar");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("ScrollBar",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.thumbOffset=0;
               _SHPainter_Styles.paddingTop=0;
               _SHPainter_Styles.borderColor=12040892;
               _SHPainter_Styles.trackColors=[9738651,15198183];
               _SHPainter_Styles.trackSkin=ScrollTrackSkin;
               _SHPainter_Styles.downArrowSkin=ScrollArrowSkin;
               _SHPainter_Styles.cornerRadius=4;
               _SHPainter_Styles.upArrowSkin=ScrollArrowSkin;
               _SHPainter_Styles.paddingLeft=0;
               _SHPainter_Styles.paddingBottom=0;
               _SHPainter_Styles.thumbSkin=ScrollThumbSkin;
               _SHPainter_Styles.paddingRight=0;
               return;
            };
         }
         styleManager.setStyleDeclaration("ScrollBar",style,false);
         style=styleManager.getStyleDeclaration("SwatchPanel");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("SwatchPanel",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.swatchGridBackgroundColor=0;
               _SHPainter_Styles.previewHeight=22;
               _SHPainter_Styles.borderColor=10856878;
               _SHPainter_Styles.paddingTop=4;
               _SHPainter_Styles.swatchWidth=12;
               _SHPainter_Styles.backgroundColor=15066855;
               _SHPainter_Styles.highlightColor=16777215;
               _SHPainter_Styles.textFieldStyleName="swatchPanelTextField";
               _SHPainter_Styles.swatchHighlightSize=1;
               _SHPainter_Styles.swatchHeight=12;
               _SHPainter_Styles.fontSize=11;
               _SHPainter_Styles.previewWidth=45;
               _SHPainter_Styles.verticalGap=0;
               _SHPainter_Styles.shadowColor=5068126;
               _SHPainter_Styles.paddingLeft=5;
               _SHPainter_Styles.swatchBorderSize=1;
               _SHPainter_Styles.paddingRight=5;
               _SHPainter_Styles.swatchBorderColor=0;
               _SHPainter_Styles.swatchGridBorderSize=0;
               _SHPainter_Styles.columnCount=20;
               _SHPainter_Styles.textFieldWidth=72;
               _SHPainter_Styles.swatchHighlightColor=16777215;
               _SHPainter_Styles.horizontalGap=0;
               _SHPainter_Styles.paddingBottom=5;
               return;
            };
         }
         styleManager.setStyleDeclaration("SwatchPanel",style,false);
         style=styleManager.getStyleDeclaration(".swatchPanelTextField");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".swatchPanelTextField",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.borderStyle="inset";
               _SHPainter_Styles.borderColor=14015965;
               _SHPainter_Styles.highlightColor=12897484;
               _SHPainter_Styles.backgroundColor=16777215;
               _SHPainter_Styles.shadowCapColor=14015965;
               _SHPainter_Styles.shadowColor=14015965;
               _SHPainter_Styles.paddingLeft=5;
               _SHPainter_Styles.buttonColor=7305079;
               _SHPainter_Styles.borderCapColor=9542041;
               _SHPainter_Styles.paddingRight=5;
               return;
            };
         }
         styleManager.setStyleDeclaration(".swatchPanelTextField",style,false);
         style=styleManager.getStyleDeclaration("TextArea");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("TextArea",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.borderStyle="solid";
               _SHPainter_Styles.verticalScrollBarStyleName="textAreaVScrollBarStyle";
               _SHPainter_Styles.backgroundColor=16777215;
               _SHPainter_Styles.horizontalScrollBarStyleName="textAreaHScrollBarStyle";
               _SHPainter_Styles.backgroundDisabledColor=14540253;
               return;
            };
         }
         styleManager.setStyleDeclaration("TextArea",style,false);
         style=styleManager.getStyleDeclaration(".textAreaVScrollBarStyle");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".textAreaVScrollBarStyle",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               return;
            };
         }
         styleManager.setStyleDeclaration(".textAreaVScrollBarStyle",style,false);
         style=styleManager.getStyleDeclaration(".textAreaHScrollBarStyle");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".textAreaHScrollBarStyle",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               return;
            };
         }
         styleManager.setStyleDeclaration(".textAreaHScrollBarStyle",style,false);
         style=styleManager.getStyleDeclaration("TextInput");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("TextInput",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.paddingTop=0;
               _SHPainter_Styles.backgroundColor=16777215;
               _SHPainter_Styles.borderSkin=HaloBorder;
               _SHPainter_Styles.backgroundDisabledColor=14540253;
               _SHPainter_Styles.paddingLeft=0;
               _SHPainter_Styles.paddingRight=0;
               return;
            };
         }
         styleManager.setStyleDeclaration("TextInput",style,false);
         style=styleManager.getStyleDeclaration(".todayStyle");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".todayStyle",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.color=16777215;
               _SHPainter_Styles.textAlign="center";
               return;
            };
         }
         styleManager.setStyleDeclaration(".todayStyle",style,false);
         style=styleManager.getStyleDeclaration(".windowStatus");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".windowStatus",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.color=6710886;
               return;
            };
         }
         styleManager.setStyleDeclaration(".windowStatus",style,false);
         style=styleManager.getStyleDeclaration(".windowStyles");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".windowStyles",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.fontWeight="bold";
               return;
            };
         }
         styleManager.setStyleDeclaration(".windowStyles",style,false);
         style=styleManager.getStyleDeclaration(".weekDayStyle");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".weekDayStyle",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.fontWeight="bold";
               _SHPainter_Styles.textAlign="center";
               return;
            };
         }
         styleManager.setStyleDeclaration(".weekDayStyle",style,false);
         style=styleManager.getStyleDeclaration("global");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("global",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.lineHeight="120%";
               _SHPainter_Styles.kerning=false;
               _SHPainter_Styles.iconColor=1118481;
               _SHPainter_Styles.horizontalAlign="left";
               _SHPainter_Styles.filled=true;
               _SHPainter_Styles.textDecoration="none";
               _SHPainter_Styles.columnCount="auto";
               _SHPainter_Styles.dominantBaseline="roman";
               _SHPainter_Styles.fontThickness=0;
               _SHPainter_Styles.focusBlendMode="normal";
               _SHPainter_Styles.blockProgression="tb";
               _SHPainter_Styles.buttonColor=7305079;
               _SHPainter_Styles.indentation=17;
               _SHPainter_Styles.textAlignLast="start";
               _SHPainter_Styles.paddingTop=0;
               _SHPainter_Styles.textAlpha=1;
               _SHPainter_Styles.rollOverColor=11723263;
               _SHPainter_Styles.fontSize=10;
               _SHPainter_Styles.bevel=true;
               _SHPainter_Styles.shadowColor=15658734;
               _SHPainter_Styles.columnGap=0;
               _SHPainter_Styles.paddingLeft=0;
               _SHPainter_Styles.indicatorGap=14;
               _SHPainter_Styles.fontWeight="normal";
               _SHPainter_Styles.focusSkin=HaloFocusRect;
               _SHPainter_Styles.dropShadowEnabled=false;
               _SHPainter_Styles.breakOpportunity="auto";
               _SHPainter_Styles.leading=2;
               _SHPainter_Styles.renderingMode="cff";
               _SHPainter_Styles.borderThickness=1;
               _SHPainter_Styles.backgroundSize="auto";
               _SHPainter_Styles.borderColor=12040892;
               _SHPainter_Styles.shadowDistance=2;
               _SHPainter_Styles.stroked=false;
               _SHPainter_Styles.digitWidth="default";
               _SHPainter_Styles.ligatureLevel="common";
               _SHPainter_Styles.verticalAlign="top";
               _SHPainter_Styles.fillAlphas=[0.6,0.4,0.75,0.65];
               _SHPainter_Styles.firstBaselineOffset="ascent";
               _SHPainter_Styles.version="4.0.0";
               _SHPainter_Styles.shadowDirection="center";
               _SHPainter_Styles.lineBreak="toFit";
               _SHPainter_Styles.fontLookup="auto";
               _SHPainter_Styles.openDuration=250;
               _SHPainter_Styles.repeatInterval=35;
               _SHPainter_Styles.fontFamily="Verdana";
               _SHPainter_Styles.paddingBottom=0;
               _SHPainter_Styles.strokeWidth=1;
               _SHPainter_Styles.lineThrough=false;
               _SHPainter_Styles.textFieldClass=UITextField;
               _SHPainter_Styles.alignmentBaseline="useDominantBaseline";
               _SHPainter_Styles.trackingLeft=0;
               _SHPainter_Styles.fontStyle="normal";
               _SHPainter_Styles.verticalGridLines=true;
               _SHPainter_Styles.dropShadowColor=0;
               _SHPainter_Styles.selectionColor=8376063;
               _SHPainter_Styles.focusRoundedCorners="tl tr bl br";
               _SHPainter_Styles.paddingRight=0;
               _SHPainter_Styles.borderSides="left top right bottom";
               _SHPainter_Styles.disabledIconColor=10066329;
               _SHPainter_Styles.textJustify="interWord";
               _SHPainter_Styles.focusColor=40447;
               _SHPainter_Styles.selectionDuration=250;
               _SHPainter_Styles.typographicCase="default";
               _SHPainter_Styles.highlightAlphas=[0.3,0];
               _SHPainter_Styles.unfocusedSelectionColor=15263976;
               _SHPainter_Styles.fillColor=16777215;
               _SHPainter_Styles.textRollOverColor=2831164;
               _SHPainter_Styles.digitCase="default";
               _SHPainter_Styles.shadowCapColor=14015965;
               _SHPainter_Styles.backgroundAlpha=1;
               _SHPainter_Styles.justificationRule="space";
               _SHPainter_Styles.roundedBottomCorners=true;
               _SHPainter_Styles.trackingRight=0;
               _SHPainter_Styles.fillColors=[16777215,13421772,16777215,15658734];
               _SHPainter_Styles.horizontalGap=8;
               _SHPainter_Styles.borderCapColor=9542041;
               _SHPainter_Styles.leadingModel="auto";
               _SHPainter_Styles.closeDuration=250;
               _SHPainter_Styles.selectionDisabledColor=14540253;
               _SHPainter_Styles.embedFonts=false;
               _SHPainter_Styles.letterSpacing=0;
               _SHPainter_Styles.focusAlpha=0.4;
               _SHPainter_Styles.borderAlpha=1;
               _SHPainter_Styles.baselineShift=0;
               _SHPainter_Styles.fontSharpness=0;
               _SHPainter_Styles.borderSkin=HaloBorder;
               _SHPainter_Styles.modalTransparencyDuration=100;
               _SHPainter_Styles.justificationStyle="pushInKinsoku";
               _SHPainter_Styles.borderStyle="inset";
               _SHPainter_Styles.textRotation="auto";
               _SHPainter_Styles.fontAntiAliasType="advanced";
               _SHPainter_Styles.errorColor=16711680;
               _SHPainter_Styles.cffHinting="horizontalStem";
               _SHPainter_Styles.direction="ltr";
               _SHPainter_Styles.locale="en";
               _SHPainter_Styles.horizontalGridLineColor=16250871;
               _SHPainter_Styles.cornerRadius=0;
               _SHPainter_Styles.modalTransparencyColor=14540253;
               _SHPainter_Styles.textIndent=0;
               _SHPainter_Styles.themeColor=40447;
               _SHPainter_Styles.verticalGridLineColor=14015965;
               _SHPainter_Styles.modalTransparency=0.5;
               _SHPainter_Styles.columnWidth="auto";
               _SHPainter_Styles.textAlign="left";
               _SHPainter_Styles.textSelectedColor=2831164;
               _SHPainter_Styles.whiteSpaceCollapse="collapse";
               _SHPainter_Styles.fontGridFitType="pixel";
               _SHPainter_Styles.horizontalGridLines=false;
               _SHPainter_Styles.useRollOver=true;
               _SHPainter_Styles.repeatDelay=500;
               _SHPainter_Styles.focusThickness=2;
               _SHPainter_Styles.disabledColor=11187123;
               _SHPainter_Styles.verticalGap=6;
               _SHPainter_Styles.inactiveSelectionColor=15263976;
               _SHPainter_Styles.modalTransparencyBlur=3;
               _SHPainter_Styles.color=734012;
               return;
            };
         }
         styleManager.setStyleDeclaration("global",style,false);
         style=styleManager.getStyleDeclaration("CursorManager");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("CursorManager",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.busyCursor=BusyCursor;
               _SHPainter_Styles.busyCursorBackground=_embed_css_Assets_swf_401520661_mx_skins_cursor_BusyCursor_898905871;
               return;
            };
         }
         styleManager.setStyleDeclaration("CursorManager",style,false);
         style=styleManager.getStyleDeclaration("DragManager");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("DragManager",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.copyCursor=_embed_css_Assets_swf_401520661_mx_skins_cursor_DragCopy_1217085305;
               _SHPainter_Styles.moveCursor=_embed_css_Assets_swf_401520661_mx_skins_cursor_DragMove_1217372885;
               _SHPainter_Styles.rejectCursor=_embed_css_Assets_swf_401520661_mx_skins_cursor_DragReject_270167229;
               _SHPainter_Styles.linkCursor=_embed_css_Assets_swf_401520661_mx_skins_cursor_DragLink_1217347310;
               _SHPainter_Styles.defaultDragImageSkin=DefaultDragImage;
               return;
            };
         }
         styleManager.setStyleDeclaration("DragManager",style,false);
         style=styleManager.getStyleDeclaration(".errorTip");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".errorTip",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.fontWeight="bold";
               _SHPainter_Styles.borderStyle="errorTipRight";
               _SHPainter_Styles.paddingTop=4;
               _SHPainter_Styles.borderColor=13510953;
               _SHPainter_Styles.color=16777215;
               _SHPainter_Styles.fontSize=9;
               _SHPainter_Styles.shadowColor=0;
               _SHPainter_Styles.paddingLeft=4;
               _SHPainter_Styles.paddingBottom=4;
               _SHPainter_Styles.paddingRight=4;
               return;
            };
         }
         styleManager.setStyleDeclaration(".errorTip",style,false);
         style=styleManager.getStyleDeclaration("SWFLoader");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("SWFLoader",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.borderStyle="none";
               _SHPainter_Styles.brokenImageSkin=_embed_css_Assets_swf_401520661___brokenImage_247155719;
               _SHPainter_Styles.brokenImageBorderSkin=BrokenImageBorderSkin;
               return;
            };
         }
         styleManager.setStyleDeclaration("SWFLoader",style,false);
         style=styleManager.getStyleDeclaration("ToolTip");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("ToolTip",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.borderStyle="toolTip";
               _SHPainter_Styles.paddingTop=2;
               _SHPainter_Styles.borderColor=9542041;
               _SHPainter_Styles.backgroundColor=16777164;
               _SHPainter_Styles.borderSkin=ToolTipBorder;
               _SHPainter_Styles.cornerRadius=2;
               _SHPainter_Styles.fontSize=9;
               _SHPainter_Styles.shadowColor=0;
               _SHPainter_Styles.paddingLeft=4;
               _SHPainter_Styles.paddingBottom=2;
               _SHPainter_Styles.backgroundAlpha=0.95;
               _SHPainter_Styles.paddingRight=4;
               return;
            };
         }
         styleManager.setStyleDeclaration("ToolTip",style,false);
         style=styleManager.getStyleDeclaration(".buttonBarFirstButtonStyle");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".buttonBarFirstButtonStyle",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.skin=null;
               return;
            };
         }
         styleManager.setStyleDeclaration(".buttonBarFirstButtonStyle",style,false);
         style=styleManager.getStyleDeclaration(".buttonBarLastButtonStyle");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration(".buttonBarLastButtonStyle",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.skin=null;
               return;
            };
         }
         styleManager.setStyleDeclaration(".buttonBarLastButtonStyle",style,false);
         style=styleManager.getStyleDeclaration("ComboBase");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("ComboBase",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.borderSkin=HaloBorder;
               return;
            };
         }
         styleManager.setStyleDeclaration("ComboBase",style,false);
         style=styleManager.getStyleDeclaration("ScrollControlBase");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("ScrollControlBase",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.borderSkin=HaloBorder;
               _SHPainter_Styles.focusRoundedCorners="tl tr bl br";
               return;
            };
         }
         styleManager.setStyleDeclaration("ScrollControlBase",style,false);
         style=styleManager.getStyleDeclaration("Slider");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            styleManager.setStyleDeclaration("Slider",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory=new function():void
            {
               _SHPainter_Styles.trackSkin=null;
               _SHPainter_Styles.trackHighlightSkin=null;
               _SHPainter_Styles.thumbSkin=null;
               return;
            };
         }
         styleManager.setStyleDeclaration("Slider",style,false);
         return;
      }
   }

}