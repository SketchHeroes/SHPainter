package mx.resources
{
   import mx.core.mx_internal;
   import mx.core.Singleton;
   import flash.utils.getDefinitionByName;

   use namespace mx_internal;

   public class ResourceManager extends Object
   {
      public function ResourceManager() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private static var implClassDependency:ResourceManagerImpl;

      private static var instance:IResourceManager;

      public static function getInstance() : IResourceManager {
         if(!instance)
         {
            if(!Singleton.getClass("mx.resources::IResourceManager"))
            {
               Singleton.registerClass("mx.resources::IResourceManager",Class(getDefinitionByName("mx.resources::ResourceManagerImpl")));
            }
            try
            {
               instance=IResourceManager(Singleton.getInstance("mx.resources::IResourceManager"));
            }
            catch(e:Error)
            {
               instance=new ResourceManagerImpl();
            }
         }
         return instance;
      }
   }

}