using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class ConfigKeys
    {
        public static string CONNECTION_STRING = "CONNECTION_STRING";
    }

    public class ConfigManager
    {
        public static ConfigManager instance;
        private static string CONFIG_PATH = ".\\config.txt";

        private Dictionary<string, string> configSet;

        public static ConfigManager GetInstance()
        {
            if (ConfigManager.instance == null) { ConfigManager.instance = new ConfigManager(); }
            return ConfigManager.instance;
        }

        public static string GetConfigValue(string configKey)
        {
            return ConfigManager.GetInstance().InstanceGetConfigValue(configKey);
        }

        public static void SetConnectionStringFromConfigurationFile() 
        {
            string value = BLL.ConfigManager.GetConfigValue(BLL.ConfigKeys.CONNECTION_STRING);
            DAL.DBConnectionManager.SetConnectionString(value);
        }

        public ConfigManager() 
        {
            configSet = new Dictionary<string, string>();
            this.ReadConfigFile();
        }

        public string InstanceGetConfigValue(string configKey)
        {
            return this.configSet[configKey];
        }
        
        private void ReadConfigFile()
        {
            using (StreamReader streamReader = new StreamReader(ConfigManager.CONFIG_PATH))
            {
                string line;
                string[] delimiter = new string[] { "==" };
                while ((line = streamReader.ReadLine()) != null)
                {
                    string[] readValues = line.Split(delimiter, StringSplitOptions.None);
                    string key = readValues[0];
                    string value = readValues[1];
                    this.configSet.Add(key, value);
                }
            }
        }
    }
}
