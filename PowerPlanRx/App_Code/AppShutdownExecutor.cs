using System;
using System.Collections.Generic;

namespace Impact
{
    /// <summary>
    /// Used to enqueue delegate methods to be executed prior to application shutdown.
    /// This class is thread safe.
    /// </summary>
    public static class AppShutdownExecutor
    {
     
        public delegate void DeferredMethod();

        private static Queue<DeferredMethod> _queue = new Queue<DeferredMethod>();

        /// <summary>
        /// Do not call this directly!
        /// This should only be called from Global.asax:Application_OnEnd().
        /// </summary>
        public static void Execute()
        {
            lock (_queue)
            {
              
                while (_queue.Count > 0)
                {
                    try
                    {
                        Delegate func = _queue.Dequeue();
                        try
                        {
                            func.DynamicInvoke();
                        }
                        catch (Exception ex)
                        {
                        
                        }
                    }
                    catch (Exception ex)
                    {
                       
                    }
                }
               
            }
        }

        /// <summary>
        /// Queue delegate to execute upon application shutdown.
        /// </summary>
        /// <param name="func">Delegate to execute on shutdown.</param>
        public static void Enqueue(DeferredMethod func)
        {
            lock (_queue)
            {
                _queue.Enqueue(func);
            }
        }
    }
}
