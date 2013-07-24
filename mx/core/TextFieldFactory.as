package mx.core
{
   import flash.utils.Dictionary;
   import flash.text.TextField;

   use namespace mx_internal;

   public class TextFieldFactory extends Object implements ITextFieldFactory
   {
      public function TextFieldFactory() {
         this.textFields=new Dictionary(true);
         this.fteTextFields=new Dictionary(true);
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private static var instance:ITextFieldFactory;

      public static function getInstance() : ITextFieldFactory {
         if(!instance)
         {
            instance=new TextFieldFactory();
         }
         return instance;
      }

      private var textFields:Dictionary;

      private var fteTextFields:Dictionary;

      public function createTextField(param1:IFlexModuleFactory) : TextField {
         var _loc4_:Object = null;
         var _loc2_:TextField = null;
         var _loc3_:Dictionary = this.textFields[param1];
         if(_loc3_)
         {
            for (_loc4_ in _loc3_)
            {
               _loc2_=TextField(_loc4_);
            }
         }
         if(param1)
         {
            _loc2_=TextField(param1.create("flash.text.TextField"));
         }
         else
         {
            _loc2_=new TextField();
         }
         if(!_loc3_)
         {
            _loc3_=new Dictionary(true);
         }
         _loc3_[_loc2_]=1;
         this.textFields[param1]=_loc3_;
         return _loc2_;
      }

      public function createFTETextField(param1:IFlexModuleFactory) : Object {
         var _loc4_:Object = null;
         var _loc2_:Object = null;
         var _loc3_:Dictionary = this.fteTextFields[param1];
         if(_loc3_)
         {
            for (_loc2_ in _loc3_)
            {
            }
         }
         if(param1)
         {
            _loc2_=param1.create("mx.core.FTETextField");
            _loc2_.fontContext=param1;
         }
         if(!_loc3_)
         {
            _loc3_=new Dictionary(true);
         }
         _loc3_[_loc2_]=1;
         this.fteTextFields[param1]=_loc3_;
         return _loc2_;
      }
   }

}