package com.csttec.server.domain;

import java.math.BigDecimal;
import java.util.Date;

public class Client {

	public enum ContractType {

	}

	public enum Status {

	}

	public enum DefaultLicenseType {

	}

	private int id = -1;
	private String name;
	private String siteName;
	private int contractType = -1;
	private String taxNo;
	private int advancedLimit = -1;
	private int standardLimit = -1;
	private int webhardLimit = -1;
	private int viewerLimit = -1;
	private BigDecimal revenueLimit;
	private BigDecimal cloudLimit;
	private int useCloudLimit = -1;
	private int useRevenueLimit = -1;
	private double storageLimit = -1;
	private double trafficLimit = -1;
	private int status = -1;
	private int defaultLicenseType = -1;
	private BigDecimal advancedPrice;
	private BigDecimal standardPrice;
	private BigDecimal webhardPrice;
	private BigDecimal viewerPrice;
	private BigDecimal storagePrice;
	private BigDecimal trafficPrice;
	private String schedulerServer;
	private double cloudAlarmTiming = -1;
	private double revenueAlarmTiming = -1;
	private Date dateUpdated;
	private Date dateOpened;
	private Date dateExpired;
	private Date dateBlocked;
	private Date dateDeleted;
	private int expireExistingSession = -1;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSiteName() {
		return siteName;
	}

	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}

	public int getContractType() {
		return contractType == null ? -1 : contractType.ordinal();
	}

	public ContractType contractType() {
		return contractType;
	}

	public void setContractType(int contractType) {
		this.contractType = ContractType.values()[contractType];
	}

	public void setContractType(String contractType) {
		this.contractType = ContractType.valueOf(contractType);
	}

	public void setContractType(ContractType contractType) {
		this.contractType = contractType;
	}

	public String getTaxNo() {
		return taxNo;
	}

	public void setTaxNo(String taxNo) {
		this.taxNo = taxNo;
	}

	public int getAdvancedLimit() {
		return advancedLimit;
	}

	public void setAdvancedLimit(int advancedLimit) {
		this.advancedLimit = advancedLimit;
	}

	public int getStandardLimit() {
		return standardLimit;
	}

	public void setStandardLimit(int standardLimit) {
		this.standardLimit = standardLimit;
	}

	public int getWebhardLimit() {
		return webhardLimit;
	}

	public void setWebhardLimit(int webhardLimit) {
		this.webhardLimit = webhardLimit;
	}

	public int getViewerLimit() {
		return viewerLimit;
	}

	public void setViewerLimit(int viewerLimit) {
		this.viewerLimit = viewerLimit;
	}

	public BigDecimal getRevenueLimit() {
		return revenueLimit
	}

	public void setRevenueLimit(BigDecimal revenueLimit) {
		this.revenueLimit = revenueLimit;
	}

	public void setRevenueLimit(long revenueLimit) {
		this.revenueLimit = BigDecimal.valueOf(revenueLimit);
	}

	public void setRevenueLimit(double revenueLimit) {
		this.revenueLimit = BigDecimal.valueOf(revenueLimit);
	}

	public BigDecimal getCloudLimit() {
		return cloudLimit
	}

	public void setCloudLimit(BigDecimal cloudLimit) {
		this.cloudLimit = cloudLimit;
	}

	public void setCloudLimit(long cloudLimit) {
		this.cloudLimit = BigDecimal.valueOf(cloudLimit);
	}

	public void setCloudLimit(double cloudLimit) {
		this.cloudLimit = BigDecimal.valueOf(cloudLimit);
	}

	public int getUseCloudLimit() {
		return useCloudLimit;
	}

	public boolean useCloudLimit() {
		return useCloudLimit == 1;
	}

	public void setUseCloudLimit(int useCloudLimit) {
		this.useCloudLimit = useCloudLimit;
	}

	public void setUseCloudLimit(boolean useCloudLimit) {
		this.useCloudLimit = useCloudLimit ? 1 : 0;
	}

	public int getUseRevenueLimit() {
		return useRevenueLimit;
	}

	public boolean useRevenueLimit() {
		return useRevenueLimit == 1;
	}

	public void setUseRevenueLimit(int useRevenueLimit) {
		this.useRevenueLimit = useRevenueLimit;
	}

	public void setUseRevenueLimit(boolean useRevenueLimit) {
		this.useRevenueLimit = useRevenueLimit ? 1 : 0;
	}

	public double getStorageLimit() {
		return storageLimit;
	}

	public void setStorageLimit(double storageLimit) {
		this.storageLimit = storageLimit;
	}

	public double getTrafficLimit() {
		return trafficLimit;
	}

	public void setTrafficLimit(double trafficLimit) {
		this.trafficLimit = trafficLimit;
	}

	public int getStatus() {
		return status == null ? -1 : status.ordinal();
	}

	public Status status() {
		return status;
	}

	public void setStatus(int status) {
		this.status = Status.values()[status];
	}

	public void setStatus(String status) {
		this.status = Status.valueOf(status);
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public int getDefaultLicenseType() {
		return defaultLicenseType == null ? -1 : defaultLicenseType.ordinal();
	}

	public DefaultLicenseType defaultLicenseType() {
		return defaultLicenseType;
	}

	public void setDefaultLicenseType(int defaultLicenseType) {
		this.defaultLicenseType = DefaultLicenseType.values()[defaultLicenseType];
	}

	public void setDefaultLicenseType(String defaultLicenseType) {
		this.defaultLicenseType = DefaultLicenseType.valueOf(defaultLicenseType);
	}

	public void setDefaultLicenseType(DefaultLicenseType defaultLicenseType) {
		this.defaultLicenseType = defaultLicenseType;
	}

	public BigDecimal getAdvancedPrice() {
		return advancedPrice
	}

	public void setAdvancedPrice(BigDecimal advancedPrice) {
		this.advancedPrice = advancedPrice;
	}

	public void setAdvancedPrice(long advancedPrice) {
		this.advancedPrice = BigDecimal.valueOf(advancedPrice);
	}

	public void setAdvancedPrice(double advancedPrice) {
		this.advancedPrice = BigDecimal.valueOf(advancedPrice);
	}

	public BigDecimal getStandardPrice() {
		return standardPrice
	}

	public void setStandardPrice(BigDecimal standardPrice) {
		this.standardPrice = standardPrice;
	}

	public void setStandardPrice(long standardPrice) {
		this.standardPrice = BigDecimal.valueOf(standardPrice);
	}

	public void setStandardPrice(double standardPrice) {
		this.standardPrice = BigDecimal.valueOf(standardPrice);
	}

	public BigDecimal getWebhardPrice() {
		return webhardPrice
	}

	public void setWebhardPrice(BigDecimal webhardPrice) {
		this.webhardPrice = webhardPrice;
	}

	public void setWebhardPrice(long webhardPrice) {
		this.webhardPrice = BigDecimal.valueOf(webhardPrice);
	}

	public void setWebhardPrice(double webhardPrice) {
		this.webhardPrice = BigDecimal.valueOf(webhardPrice);
	}

	public BigDecimal getViewerPrice() {
		return viewerPrice
	}

	public void setViewerPrice(BigDecimal viewerPrice) {
		this.viewerPrice = viewerPrice;
	}

	public void setViewerPrice(long viewerPrice) {
		this.viewerPrice = BigDecimal.valueOf(viewerPrice);
	}

	public void setViewerPrice(double viewerPrice) {
		this.viewerPrice = BigDecimal.valueOf(viewerPrice);
	}

	public BigDecimal getStoragePrice() {
		return storagePrice
	}

	public void setStoragePrice(BigDecimal storagePrice) {
		this.storagePrice = storagePrice;
	}

	public void setStoragePrice(long storagePrice) {
		this.storagePrice = BigDecimal.valueOf(storagePrice);
	}

	public void setStoragePrice(double storagePrice) {
		this.storagePrice = BigDecimal.valueOf(storagePrice);
	}

	public BigDecimal getTrafficPrice() {
		return trafficPrice
	}

	public void setTrafficPrice(BigDecimal trafficPrice) {
		this.trafficPrice = trafficPrice;
	}

	public void setTrafficPrice(long trafficPrice) {
		this.trafficPrice = BigDecimal.valueOf(trafficPrice);
	}

	public void setTrafficPrice(double trafficPrice) {
		this.trafficPrice = BigDecimal.valueOf(trafficPrice);
	}

	public String getSchedulerServer() {
		return schedulerServer;
	}

	public void setSchedulerServer(String schedulerServer) {
		this.schedulerServer = schedulerServer;
	}

	public double getCloudAlarmTiming() {
		return cloudAlarmTiming;
	}

	public void setCloudAlarmTiming(double cloudAlarmTiming) {
		this.cloudAlarmTiming = cloudAlarmTiming;
	}

	public double getRevenueAlarmTiming() {
		return revenueAlarmTiming;
	}

	public void setRevenueAlarmTiming(double revenueAlarmTiming) {
		this.revenueAlarmTiming = revenueAlarmTiming;
	}

	public Date getDateUpdated() {
		return dateUpdated;
	}

	public void setDateUpdated(Date dateUpdated) {
		this.dateUpdated = dateUpdated;
	}

	public Date getDateOpened() {
		return dateOpened;
	}

	public void setDateOpened(Date dateOpened) {
		this.dateOpened = dateOpened;
	}

	public Date getDateExpired() {
		return dateExpired;
	}

	public void setDateExpired(Date dateExpired) {
		this.dateExpired = dateExpired;
	}

	public Date getDateBlocked() {
		return dateBlocked;
	}

	public void setDateBlocked(Date dateBlocked) {
		this.dateBlocked = dateBlocked;
	}

	public Date getDateDeleted() {
		return dateDeleted;
	}

	public void setDateDeleted(Date dateDeleted) {
		this.dateDeleted = dateDeleted;
	}

	public int getExpireExistingSession() {
		return expireExistingSession;
	}

	public boolean expireExistingSession() {
		return expireExistingSession == 1;
	}

	public void setExpireExistingSession(int expireExistingSession) {
		this.expireExistingSession = expireExistingSession;
	}

	public void setExpireExistingSession(boolean expireExistingSession) {
		this.expireExistingSession = expireExistingSession ? 1 : 0;
	}

}