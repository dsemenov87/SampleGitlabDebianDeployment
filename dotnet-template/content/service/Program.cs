using System;
using Microsoft.Extensions.Logging;

namespace template.Service
{
    class Program
    {
        static ILoggerFactory _loggerFactory;

        static EnvironmentConfig _config = new EnvironmentConfig();

        public static void Main(string[] args)
        {
            //LoggingToConsole();
        }

        private static void LoggingToConsole(ILoggingBuilder builder = null)
        {
            _loggerFactory = new LoggerFactory().AddConsole(_config.MinLogLevel);

            if (builder != null)
            {
                builder.AddConsole().SetMinimumLevel(_config.MinLogLevel);
            }
        }
    }
}
