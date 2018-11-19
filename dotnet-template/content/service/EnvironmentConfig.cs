using System;
using Microsoft.Extensions.Logging;

namespace template.Service
{
    public class EnvironmentConfig
    {
        public LogLevel MinLogLevel { get; } =
            (LogLevel)Enum.Parse(typeof(LogLevel), Env("MIN_LOG_LEVEL"));

        public string Vhost { get; } = Env("RABBITMQ_VHOST");

        static string Env(string name) => Environment.GetEnvironmentVariable(name);
    }
}