public with sharing class ContentController {

    //アップロードファイル情報属性
    public String fileName{get; set;}
    transient public Blob fileBody{get; set;}
    public Integer fileSize{get; set;}

    //出力用属性
    public Boolean success{get; set;}
    public String contentVersionId{get; set;}
    public String uri{get; set;}

    /**
     * Uploadボタン処理
     */
    public Pagereference upload() {

        // ファイルサイズが10MB以上でエラー
        if(ApexPages.hasMessages(ApexPages.Severity.ERROR)) {
            System.debug('Exceeds File Size limit, abort processing. ApexPages.getMessages() ' + ApexPages.getMessages());
            return null;
        }

        // ファイル情報を元にContentVersionオブジェクトに登録
        ContentVersion v = new ContentVersion();
        v.VersionData = fileBody;
        v.Title = fileName;
        v.PathOnClient = fileName;
        insert v;

        // 出力用にパラメータ設定
        success = true;
        contentVersionId = v.Id;
        uri = '/sfc/servlet.shepherd/version/download/' + contentVersionId;

        return null;
    }
}
