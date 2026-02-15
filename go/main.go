package main

import "fmt"

type Config struct {
	asia   *RegionalConfig
	europe *RegionalConfig
}

type RegionalConfig struct {
	app *AppConfig
}

type AppConfig struct {
	version string
}

func (cfg *Config) GetRegionalConfig() *RegionalConfig {
	// Hardcoded for Asia for demo
	return cfg.asia
}

func (cfg *RegionalConfig) GetAppConfig() *AppConfig {
	if cfg == nil {
		return nil
	}
	return cfg.app
}

func (cfg *AppConfig) GetVersion() string {
	if cfg == nil {
		return ""
	}
	return cfg.version
}

func GetConfig() *Config {
	cfg := &Config{}
	return cfg
}

func main() {
	var cfg *Config
	var appCfg *AppConfig
	var version string

	// Normal case
	cfg = &Config{
		asia: &RegionalConfig{
			app: &AppConfig{
				version: "1.0.0",
			},
		}}
	appCfg = cfg.GetRegionalConfig().GetAppConfig()
	version = appCfg.GetVersion()
	fmt.Printf("Version is <%v>\n", version)

	// Example 1:
	var p *Config
	if 1 == 1 {
		p = &Config{}
	}
	print(p.asia) // nilness reports NO error here, but NilAway does.

	// Unexpected case
	//lint:ignore (this directive will not work, see https://github.com/golang/go/issues/74273)
	cfg = &Config{asia: &RegionalConfig{}}
	appCfg = GetConfig().GetRegionalConfig().GetAppConfig() // This WILL NOT panic!
	version = appCfg.GetVersion()
	fmt.Printf("Version is <%v>\n", version)
}
