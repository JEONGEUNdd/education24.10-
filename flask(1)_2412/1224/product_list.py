from flask import Flask,render_template,request
app=Flask(__name__)


@app.template_filter('currency')
def format_currency(value):
    return "${:,.2f}".format(value)

products=[
    {
        'name':'제품 A',
        'price':10000,
        'description':'이 제품은 매우 훌륭한 제품입니다. 구매하시면 만족하실 것입니다.'
    },
    {
        'name':'제품 B',
        'price':20000,
        'description':'이 제품은 특별합니다. 품질이 탁월하며 사용하기 편합니다.'
    },
    {
        'name':'제품 C',
        'price':15000,
        'description':'이 제품은 다양한 기능을 제공하며 합리적인 가격으로 구입하실 수 있습니다.'
    }
]
@app.route('/')
def index():
    return render_template('product_list.html',products=products)

if __name__=='__main__':
    app.run(debug=True) 
 