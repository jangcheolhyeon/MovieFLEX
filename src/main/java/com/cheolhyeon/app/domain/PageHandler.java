package com.cheolhyeon.app.domain;

public class PageHandler {
    private SearchCondition sc;
    private Integer totalCnt;
    private Integer totalPage;
//    private Integer page;
//    private Integer pageSize = 10;
    private Integer naviSize = 10;
    private Integer beginPage;
    private Integer endPage;
    private boolean showPrev;
    private boolean showNext;


    public PageHandler(){};
    public PageHandler(Integer totalCnt, SearchCondition sc) {
        this.totalCnt = totalCnt;
        this.sc = sc;

        this.totalPage = (int) Math.ceil(totalCnt / (double)sc.getPageSize());
        this.beginPage = (sc.getPage()-1) / (naviSize) * naviSize + 1;
        //
        this.endPage = Math.min((beginPage + naviSize - 1), totalPage);

        this.showPrev = beginPage != 1;
        this.showNext = totalPage != endPage;
    }


    void print(){
        if(showPrev) System.out.print("< ");
        for(int i=beginPage; i<=endPage; i++){
            System.out.print(i + " ");
        }
        if(showNext) System.out.print(">");
    }


    @Override
    public String toString() {
        return "PageHandler{" +
                "totalCnt=" + totalCnt +
                ", totalPage=" + totalPage +
                ", page=" + sc.getPage() +
                ", pageSize=" + sc.getPageSize() +
                ", naviSize=" + naviSize +
                ", beginPage=" + beginPage +
                ", endPage=" + endPage +
                ", showPrev=" + showPrev +
                ", showNext=" + showNext +
                '}';
    }

    public Integer getTotalCnt() {
        return totalCnt;
    }

    public void setTotalCnt(Integer totalCnt) {
        this.totalCnt = totalCnt;
    }

    public Integer getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(Integer totalPage) {
        this.totalPage = totalPage;
    }

    public Integer getNaviSize() {
        return naviSize;
    }

    public void setNaviSize(Integer naviSize) {
        this.naviSize = naviSize;
    }

    public Integer getBeginPage() {
        return beginPage;
    }

    public void setBeginPage(Integer beginPage) {
        this.beginPage = beginPage;
    }

    public Integer getEndPage() {
        return endPage;
    }

    public void setEndPage(Integer endPage) {
        this.endPage = endPage;
    }

    public boolean isShowPrev() {
        return showPrev;
    }

    public void setShowPrev(boolean showPrev) {
        this.showPrev = showPrev;
    }

    public boolean isShowNext() {
        return showNext;
    }

    public void setShowNext(boolean showNext) {
        this.showNext = showNext;
    }

    public SearchCondition getSc() {
        return sc;
    }

    public void setSc(SearchCondition sc) {
        this.sc = sc;
    }
}
