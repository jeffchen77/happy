package com.happy.conf;

import java.io.File;

public class ConfFactory {
	public static String CONF_HOME = "/opt/happy/conf";

	private Conf globalConf = null;

	private static ConfFactory instance = null;

	private static ConfFactory getInstance() {
		if (instance == null) {
			instance = new ConfFactory();
		}

		return instance;
	}

	private ConfFactory() {
		globalConf = new Conf();
		globalConf.loadResource(new File(CONF_HOME + "/conf-default.xml"));
//		globalConf.loadResource(new File(CONF_HOME + "/conf-dev.xml"));
	}

	/**
	 * 获取全局的配置文件
	 * 
	 * @return
	 */
	private Conf getAppConf() {
		return globalConf;
	}

	/**
	 * 方便全局访问
	 * 
	 * @return
	 */
	public static Conf getConf() {
		return ConfFactory.getInstance().getAppConf();
	}

	public static void addResource(String filename) {
		getConf().loadResource(new File(CONF_HOME + File.separator + filename));
//		getConf().loadResource(new File(CONF_HOME + "/conf-site.xml"));
	}

	/*
	 * private class MyFileListener implements FileListener {
	 * 
	 * public void fileChanged(File file) { if
	 * (globalConf.containsConfFile(file) && file.exists()) {
	 * globalConf.loadResource(file); LOG.info("config file '" +
	 * file.getAbsolutePath() + "' has been reloaded."); } } }
	 * 
	 * public static void main(String[] args) { Conf conf =
	 * ConfFactory.getInstance().getAppConf(); try { conf.write(System.out); }
	 * catch (IOException e) { e.printStackTrace(); }
	 * 
	 * // Avoid program exit while (!false) ; } //
	 */
}
