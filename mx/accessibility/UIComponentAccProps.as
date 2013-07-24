package mx.accessibility
{
   import flash.accessibility.AccessibilityProperties;
   import mx.core.mx_internal;
   import mx.core.UIComponent;
   import flash.events.Event;
   import flash.accessibility.Accessibility;

   use namespace mx_internal;

   public class UIComponentAccProps extends AccessibilityProperties
   {
      public function UIComponentAccProps(param1:UIComponent) {
         super();
         this.master=param1;
         if(param1.accessibilityProperties)
         {
            silent=param1.accessibilityProperties.silent;
            forceSimple=param1.accessibilityProperties.forceSimple;
            noAutoLabeling=param1.accessibilityProperties.noAutoLabeling;
            if(param1.accessibilityProperties.name)
            {
               name=param1.accessibilityProperties.name;
            }
            if(param1.accessibilityProperties.description)
            {
               description=param1.accessibilityProperties.description;
            }
            if(param1.accessibilityProperties.shortcut)
            {
               shortcut=param1.accessibilityProperties.shortcut;
            }
         }
         if(AccImpl.getMatchingDefinition(this.master,AccImpl.getDefinitions("ScrollBar",this.master.moduleFactory)))
         {
            silent=true;
            return;
         }
         if(this.isFormItemLabel(this.master))
         {
            name=AccImpl.getFormName(this.master);
            silent=true;
            return;
         }
         if(componentShouldBeSilent(param1))
         {
            name="";
            return;
         }
         if((AccImpl.isFormHeading(this.master)) && this.master.tabIndex > 0)
         {
            try
            {
               if(Object(this.master).labelDisplay.tabIndex == -1)
               {
                  Object(this.master).labelDisplay.tabIndex=this.master.tabIndex;
               }
            }
            catch(e:Error)
            {
            }
         }
         var _loc2_:String = AccImpl.getFormName(this.master);
         if((_loc2_) && !(_loc2_.length == 0))
         {
            name=_loc2_ + name;
         }
         if((this.master.toolTip) && !(this.master.toolTip.length == 0))
         {
            if(!param1.accessibilityProperties || (param1.accessibilityProperties) && (!param1.accessibilityProperties.name))
            {
               this.oldToolTip=" " + this.master.toolTip;
               name=name + this.oldToolTip;
            }
         }
         if((this.master.errorString) && !(this.master.errorString.length == 0))
         {
            this.oldErrorString=" " + this.master.errorString;
            name=name + this.oldErrorString;
         }
         this.master.addEventListener("toolTipChanged",this.eventHandler);
         this.master.addEventListener("errorStringChanged",this.eventHandler);
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static function enableAccessibility() : void {
         UIComponent.createAccessibilityImplementation=createAccessibilityImplementation;
         return;
      }

      mx_internal  static function createAccessibilityImplementation(param1:UIComponent) : void {
         param1.accessibilityProperties=new UIComponentAccProps(param1);
         return;
      }

      mx_internal  static function componentShouldBeSilent(param1:UIComponent) : Boolean {
         var _loc2_:Class = Class(AccImpl.getDefinition("spark.components.Group",param1.moduleFactory));
         if(!_loc2_)
         {
            return false;
         }
         var _loc3_:UIComponent = AccImpl.findMatchingAncestor(param1,AccImpl.isFormItem);
         if(!_loc3_)
         {
            return false;
         }
         if(param1  is  _loc2_ && param1.parent.parent === _loc3_)
         {
            return true;
         }
         var _loc4_:Class = Class(AccImpl.getDefinition("spark.components.Image",param1.moduleFactory));
         if(!_loc4_)
         {
            return false;
         }
         if(param1  is  _loc4_ && param1.parent  is  _loc2_ && param1.parent.parent.parent === _loc3_)
         {
            return true;
         }
         return false;
      }

      protected function isFormItemLabel(param1:UIComponent) : Boolean {
         var _loc2_:String = this.master.name;
         if(_loc2_ == "labelDisplay" || _loc2_ == "sequenceLabelDisplay" || _loc2_ == "helpContentGroup" || _loc2_ == "errorTextDisplay")
         {
            return true;
         }
         return Boolean(AccImpl.getMatchingDefinition(this.master,AccImpl.getDefinitions("FormItemLabel",this.master.moduleFactory)));
      }

      private var oldToolTip:String;

      private var oldErrorString:String;

      protected var master:UIComponent;

      protected function eventHandler(param1:Event) : void {
         var _loc2_:* = 0;
         switch(param1.type)
         {
            case "errorStringChanged":
               if((name) && (!(name.length == 0)) && (this.oldErrorString))
               {
                  _loc2_=name.indexOf(this.oldErrorString);
                  if(_loc2_ != -1)
                  {
                     name=name.substring(0,_loc2_) + name.substring(_loc2_ + this.oldErrorString.length);
                  }
                  this.oldErrorString=null;
               }
               if((this.master.errorString) && !(this.master.errorString.length == 0))
               {
                  if(!name)
                  {
                     name="";
                  }
                  this.oldErrorString=" " + this.master.errorString;
                  name=name + this.oldErrorString;
               }
               Accessibility.updateProperties();
               break;
            case "toolTipChanged":
               if((name) && (!(name.length == 0)) && (this.oldToolTip))
               {
                  _loc2_=name.indexOf(this.oldToolTip);
                  if(_loc2_ != -1)
                  {
                     name=name.substring(0,_loc2_) + name.substring(_loc2_ + this.oldToolTip.length);
                  }
                  this.oldToolTip=null;
               }
               if((this.master.toolTip) && !(this.master.toolTip.length == 0))
               {
                  if(!this.master.accessibilityProperties || (this.master.accessibilityProperties) && (!this.master.accessibilityProperties.name))
                  {
                     if(!name)
                     {
                        name="";
                     }
                     this.oldToolTip=" " + this.master.toolTip;
                     name=name + this.oldToolTip;
                  }
               }
               Accessibility.updateProperties();
               break;
         }
         return;
      }
   }

}