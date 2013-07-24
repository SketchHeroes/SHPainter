package 
{
   import mx.binding.IWatcherSetupUtil2;
   import mx.core.IFlexModuleFactory;
   import components.Publish;
   import mx.binding.StaticPropertyWatcher;
   import mx.binding.PropertyWatcher;
   import mx.core.Application;


   public class _components_PublishWatcherSetupUtil extends Object implements IWatcherSetupUtil2
   {
      public function _components_PublishWatcherSetupUtil() {
         super();
         return;
      }

      public static function init(param1:IFlexModuleFactory) : void {
         Publish.watcherSetupUtil=new _components_PublishWatcherSetupUtil();
         return;
      }

      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void {
         param5[0]=new StaticPropertyWatcher("application",null,[param4[0]],null);
         param5[1]=new PropertyWatcher("categoriesXmlList",null,[param4[0]],null);
         param5[0].updateParent(Application);
         param5[0].addChild(param5[1]);
         return;
      }
   }

}