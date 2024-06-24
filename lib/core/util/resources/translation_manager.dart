class TranslationModel {
  late String success;
  late String error;
  late String info;
  late String warning;
  late String deleteMessage;
  late String cancel;
  late String yesOnly;
  late String gymawy;
  late String login;
  late String welcome;
  late String email;
  late String password;
  late String forget;
  late String newUser;
  late String registerNow;
  late String register;
  late String fullName;
  late String userName;
  late String mobile;
  late String whatsapp;
  late String confirmPassword;
  late String shopName;
  late String categories;
  late String shopMobile;
  late String shopWhatsapp;
  late String city;
  late String government;
  late String read;
  late String terms;
  late String noData;
  late String subCategories;
  late String search;
  late String forgetPasswordScreen;
  late String send;
  late String loading;
  late String change;
  late String exponile;
  late String lang;
  late String home;
  late String products;
  late String offers;
  late String orders;
  late String myShop;
  late String settings;
  late String productsCategory;
  late String productApprovalStatus;
  late String productStatus;
  late String productWarehouse;
  late String filter;
  late String accepted;
  late String pending;
  late String rejected;
  late String activePercentage;
  late String inactivePercentage;
  late String update;
  late String later;
  late String sure;
  late String resetPassword;
  late String subUsers;
  late String language;
  late String deleteAccount;
  late String logout;
  late String wallet;
  late String currency;
  late String oldPassword;
  late String newPassword;
  late String confirmNewPassword;
  late String addSubUser;
  late String roles;
  late String rate;
  late String location;
  late String areaName;
  late String cityName;
  late String streetName;
  late String buildingName;
  late String floorNo;
  late String flatNo;
  late String warehouses;
  late String editShop;
  late String shopEN;
  late String shopAR;
  late String commercialImage;
  late String vatImage;
  late String save;
  late String shopManagement;
  late String streetNameEn;
  late String streetNameAr;
  late String postalNo;
  late String requiredField;
  late String emailFormatValidation;
  late String lengthPhone;
  late String startPhoneValidation;
  late String lengthPassword;
  late String passwordFirstValidation;
  late String passwordSecondValidation;
  late String passwordThirdValidation;
  late String passwordConfirmationValidation;
  late String termsAndConditions;
  late String pickArea;
  late String pickCity;
  late String pickCategory;
  late String fillData;
  late String processing;
  late String link;
  late String unlink;
  late String deliveryMethods;
  late String deliveryBoy;
  late String distance;
  late String outZone;
  late String inZone;
  late String allZones;
  late String outZones;
  late String inZones;
  late String deliveryFees;
  late String deliveryTime;
  late String moreItems;
  late String undefined;
  late String deliveryMethod;
  late String createdAt;
  late String updatedAt;
  late String exit;
  late String date;
  late String quantity;
  late String orderNumber;
  late String paymentMethod;
  late String warehouseMethod;
  late String status;
  late String orderDetails;
  late String placeOrder;
  late String preparing;
  late String packing;
  late String canceled;
  late String delivered;
  late String changeStatus;
  late String orderDate;
  late String customerName;
  late String productName;
  late String price;
  late String firstFeature;
  late String secondFeature;
  late String buy;
  late String get;
  late String totalPayment;
  late String fees;
  late String discountValue;
  late String totalAfterDiscount;
  late String lastUpdate;
  late String manageProducts;
  late String delete;
  late String from;
  late String to;
  late String productDetails;
  late String color;
  late String size;
  late String other;
  late String editPrice;
  late String inStock;
  late String outStock;
  late String stock;
  late String editStock;
  late String changeStockValidation;
  late String createProduct;
  late String productNameAr;
  late String productNameEn;
  late String productDesAr;
  late String productDesEn;
  late String active;
  late String inActive;
  late String pickSubCategory;
  late String pickWarehouse;
  late String pickDelivery;
  late String withOutFeature;
  late String selectFeature;
  late String pickColor;
  late String sku;
  late String weight;
  late String reorder;
  late String lengthValidationImage;
  late String sizeValidationImage;
  late String packageType;
  late String saveAndAddMore;
  late String emptyImage;
  late String pickPackage;
  late String changePriceForAllFeatures;
  late String changeQuantityForAllFeatures;
  late String productManagement;
  late String addNewOffer;
  late String productNumbers;
  late String offerName;
  late String offerType;
  late String offerDetails;
  late String buyAmount;
  late String getAmount;
  late String promoCode;
  late String createOffer;
  late String deleteProductValidation;
  late String launchingDate;
  late String offerNameAr;
  late String offerNameEn;
  late String percentage;
  late String emptyBannerOffer;
  late String validationPercentage;
  late String selectProducts;
  late String guest;
  late String stores;
  late String reviews;
  late String relatedProductsFromOtherStores;
  late String relatedProductsFromSameStores;
  late String addToCart;
  late String shop;
  late String seeAll;
  late String total;
  late String select;
  late String completeOffer;
  late String offerCompleted;
  late String addresses;
  late String notifications;
  late String about;
  late String notAvailable;
  late String becomeMerchant;
  late String aboutExponile;
  late String contactUs;
  late String name;
  late String complain;
  late String submit;
  late String favourites;
  late String addAddress;
  late String landmark;
  late String homeLocation;
  late String jobLocation;
  late String main;
  late String bestSeller;
  late String newArrivals;
  late String hotDeals;
  late String storesCategories;
  late String totalOffers;
  late String discover;
  late String newArrival;
  late String bestSelling;
  late String recentlyViewed;
  late String financialTransactions;
  late String rateStore;
  late String rateProduct;
  late String next;



  TranslationModel.fromJson(Map<String, dynamic> json) {
    yesOnly = json['yesOnly'];
    cancel = json['cancel'];
    success = json['success'];
    error = json['error'];
    info = json['info'];
    warning = json['warning'];
    deleteMessage = json['deleteMessage'];
    login= json['login'];
    welcome= json['welcome'];
    email= json['email'];
    password= json['password'];
    forget= json['forget'];
    newUser= json['newUser'];
    registerNow= json['registerNow'];
    register= json['register'];
    fullName= json['fullName'];
    userName= json['userName'];
    mobile= json['mobile'];
    whatsapp= json['whatsapp'];
    confirmPassword= json['confirmPassword'];
    shopName= json['shopName'];
    categories= json['categories'];
    shopMobile= json['shopMobile'];
    shopWhatsapp= json['shopWhatsapp'];
    city= json['city'];
    government= json['government'];
    read= json['read'];
    terms= json['terms'];
    noData= json['noData'];
    subCategories= json['subCategories'];
    search= json['search'];
    forgetPasswordScreen= json['forgetPasswordScreen'];
    send= json['send'];
    loading= json['loading'];
    change= json['change'];
    exponile= json['exponile'];
    lang= json['lang'];
    home= json['home'];
    products= json['products'];
    offers= json['offers'];
    orders= json['orders'];
    myShop= json['myShop'];
    settings= json['settings'];
    productsCategory= json['productsCategory'];
    productApprovalStatus= json['productApprovalStatus'];
    productStatus= json['productStatus'];
    productWarehouse= json['productWarehouse'];
    filter= json['filter'];
    accepted= json['accepted'];
    pending= json['pending'];
    rejected= json['rejected'];
    activePercentage= json['activePercentage'];
    inactivePercentage= json['inactivePercentage'];
    update= json['update'];
    later= json['later'];
    sure= json['sure'];
    resetPassword= json['resetPassword'];
    subUsers= json['subUsers'];
    language= json['language'];
    deleteAccount= json['deleteAccount'];
    logout= json['logout'];
    wallet= json['wallet'];
    currency= json['currency'];
    oldPassword= json['oldPassword'];
    newPassword= json['newPassword'];
    confirmNewPassword= json['confirmNewPassword'];
    addSubUser= json['addSubUser'];
    roles= json['roles'];
    rate= json['rate'];
    location= json['location'];
    areaName= json['areaName'];
    cityName = json['cityName'];
    streetName= json['streetName'];
    buildingName= json['buildingName'];
    floorNo= json['floorNo'];
    flatNo= json['flatNo'];
    warehouses= json['warehouses'];
    editShop= json['editShop'];
    shopEN= json['shopEN'];
    shopAR= json['shopAR'];
    commercialImage= json['commercialImage'];
    vatImage= json['vatImage'];
    save= json['save'];
    shopManagement= json['shopManagement'];
    streetNameEn= json['streetNameEn'];
    streetNameAr= json['streetNameAr'];
    postalNo= json['postalNo'];
    requiredField= json['requiredField'];
    emailFormatValidation= json['emailFormatValidation'];
    lengthPhone= json['lengthPhone'];
    startPhoneValidation= json['startPhoneValidation'];
    lengthPassword= json['lengthPassword'];
    passwordFirstValidation= json['passwordFirstValidation'];
    passwordSecondValidation= json['passwordSecondValidation'];
    passwordThirdValidation= json['passwordThirdValidation'];
    passwordConfirmationValidation= json['passwordConfirmationValidation'];
    termsAndConditions= json['termsAndConditions'];
    pickArea= json['pickArea'];
    pickCity= json['pickCity'];
    pickCategory= json['pickCategory'];
    fillData= json['fillData'];
    processing= json['processing'];
    link= json['link'];
    unlink= json['unlink'];
    deliveryMethods= json['deliveryMethods'];
    deliveryBoy= json['deliveryBoy'];
    distance= json['distance'];
    outZone= json['outZone'];
    inZone= json['inZone'];
    allZones= json['allZones'];
    outZones= json['outZones'];
    inZones= json['inZones'];
    deliveryFees= json['deliveryFees'];
    deliveryTime= json['deliveryTime'];
    moreItems= json['moreItems'];
    undefined= json['undefined'];
    deliveryMethod= json['deliveryMethod'];
    createdAt= json['createdAt'];
    updatedAt= json['updatedAt'];
    exit= json['exit'];
    date= json['date'];
    quantity= json['quantity'];
    orderNumber= json['orderNumber'];
    paymentMethod= json['paymentMethod'];
    warehouseMethod= json['warehouseMethod'];
    status= json['status'];
    orderDetails= json['orderDetails'];
    placeOrder= json['placeOrder'];
    preparing= json['preparing'];
    packing= json['packing'];
    canceled= json['canceled'];
    delivered= json['delivered'];
    changeStatus= json['changeStatus'];
    orderDate= json['orderDate'];
    customerName= json['customerName'];
    productName= json['productName'];
    price= json['price'];
    firstFeature= json['firstFeature'];
    secondFeature= json['secondFeature'];
    buy= json['buy'];
    get= json['get'];
    totalPayment= json['totalPayment'];
    fees= json['fees'];
    discountValue= json['discountValue'];
    totalAfterDiscount= json['totalAfterDiscount'];
    lastUpdate= json['lastUpdate'];
    manageProducts= json['manageProducts'];
    delete= json['delete'];
    from= json['from'];
    to= json['to'];
    productDetails= json['productDetails'];
    color= json['color'];
    size= json['size'];
    other= json['other'];
    editPrice= json['editPrice'];
    inStock= json['inStock'];
    outStock= json['outStock'];
    stock= json['stock'];
    editStock= json['editStock'];
    changeStockValidation= json['changeStockValidation'];
    createProduct= json['createProduct'];
    productNameAr= json['productNameAr'];
    productNameEn= json['productNameEn'];
    productDesAr= json['productDesAr'];
    productDesEn= json['productDesEn'];
    active= json['active'];
    inActive= json['inActive'];
    pickSubCategory= json['pickSubCategory'];
    pickWarehouse= json['pickWarehouse'];
    pickDelivery= json['pickDelivery'];
    withOutFeature= json['withOutFeature'];
    selectFeature= json['selectFeature'];
    pickColor= json['pickColor'];
    sku= json['sku'];
    weight= json['weight'];
    reorder= json['reorder'];
    lengthValidationImage= json['lengthValidationImage'];
    sizeValidationImage= json['sizeValidationImage'];
    packageType= json['packageType'];
    saveAndAddMore= json['saveAndAddMore'];
    emptyImage= json['emptyImage'];
    pickPackage= json['pickPackage'];
    changePriceForAllFeatures= json['changePriceForAllFeatures'];
    changeQuantityForAllFeatures= json['changeQuantityForAllFeatures'];
    productManagement= json['productManagement'];
    addNewOffer= json['addNewOffer'];
    productNumbers= json['productNumbers'];
    offerName= json['offerName'];
    offerType= json['offerType'];
    offerDetails= json['offerDetails'];
    buyAmount= json['buyAmount'];
    getAmount= json['getAmount'];
    promoCode= json['promoCode'];
    createOffer= json['createOffer'];
    deleteProductValidation= json['deleteProductValidation'];
    launchingDate= json['launchingDate'];
    offerNameAr= json['offerNameAr'];
    offerNameEn= json['offerNameEn'];
    percentage= json['percentage'];
    emptyBannerOffer= json['emptyBannerOffer'];
    validationPercentage= json['validationPercentage'];
    selectProducts= json['selectProducts'];
    guest= json['guest'];
    stores= json['stores'];
    reviews= json['reviews'];
    relatedProductsFromOtherStores= json['relatedProductsFromOtherStores'];
    relatedProductsFromSameStores= json['relatedProductsFromSameStores'];
    addToCart= json['addToCart'];
    shop= json['shop'];
    seeAll= json['seeAll'];
    total= json['total'];
    select= json['select'];
    completeOffer= json['completeOffer'];
    offerCompleted= json['offerCompleted'];
    addresses= json['addresses'];
    notifications= json['notifications'];
    about= json['about'];
    notAvailable= json['notAvailable'];
    becomeMerchant= json['becomeMerchant'];
    aboutExponile= json['aboutExponile'];
    contactUs= json['contactUs'];
    name= json['name'];
    complain= json['complain'];
    submit= json['submit'];
    favourites= json['favourites'];
    addAddress= json['addAddress'];
    landmark= json['landmark'];
    homeLocation= json['homeLocation'];
    jobLocation= json['jobLocation'];
    main= json['main'];
    bestSeller= json['bestSeller'];
    newArrivals= json['newArrivals'];
    hotDeals= json['hotDeals'];
    storesCategories= json['storesCategories'];
    totalOffers= json['totalOffers'];
    discover= json['discover'];
    newArrival= json['newArrival'];
    bestSelling= json['bestSelling'];
    recentlyViewed= json['recentlyViewed'];
    financialTransactions= json['financialTransactions'];
    rateStore= json['rateStore'];
    rateProduct= json['rateProduct'];
    next= json['next'];
  }
}
