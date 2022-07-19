//
//  NetworkManagerMock.swift
//  MeritaTests
//
//  Created by Abo Saleh on 19/07/2022.
//

import Foundation
@testable import Merita
class NetworkMangerMock: ApiService {
    
    
    
    var shouldReturnError: Bool
    
    init(shouldReturnError:Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    //MARK: - jsonResponseBrands
    
    let jsonResponseBrands: [[String: Any]] = [
        [
            "id": 409147113686,
            "handle": "adidas",
            "title": "ADIDAS",
            "updated_at": "2022-06-27T00:00:18+02:00",
            "body_html": "Adidas collection",
            "published_at": "2022-06-26T23:57:22+02:00",
            "sort_order": "best-selling",
            "template_suffix": (Any).self,
            "disjunctive": false,
            "rules": [
                [
                    "column": "title",
                    "relation": "contains",
                    "condition": "ADIDAS"
                ]
            ],
            "published_scope": "web",
            "admin_graphql_api_id": "gid://shopify/Collection/409147113686",
            "image": [
                "created_at": "2022-06-26T23:57:22+02:00",
                "alt": (Any).self,
                "width": 1000,
                "height": 676,
                "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/collections/97a3b1227876bf099d279fd38290e567.jpg?v=1656280642"
            ]
        ],
        [
            "id": 409147211990,
            "handle": "asics-tiger",
            "title": "ASICS TIGER",
            "updated_at": "2022-06-27T00:05:23+02:00",
            "body_html": "Asics Tiger collection",
            "published_at": "2022-06-26T23:57:25+02:00",
            "sort_order": "best-selling",
            "template_suffix": (Any).self,
            "disjunctive": false,
            "rules": [
                [
                    "column": "title",
                    "relation": "contains",
                    "condition": "ASICS TIGER"
                ]
            ],
            "published_scope": "web",
            "admin_graphql_api_id": "gid://shopify/Collection/409147211990",
            "image": [
                "created_at": "2022-06-26T23:57:25+02:00",
                "alt": (Any).self,
                "width": 425,
                "height": 220,
                "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/collections/b351cead33b2b72e7177e70512530f09.jpg?v=1656280645"
            ]
        ],
        [
            "id": 409147179222,
            "handle": "converse",
            "title": "CONVERSE",
            "updated_at": "2022-06-27T00:05:24+02:00",
            "body_html": "Converse collection",
            "published_at": "2022-06-26T23:57:24+02:00",
            "sort_order": "best-selling",
            "template_suffix": (Any).self,
            "disjunctive": false,
            "rules": [
                [
                    "column": "title",
                    "relation": "contains",
                    "condition": "CONVERSE"
                ]
            ],
            "published_scope": "web",
            "admin_graphql_api_id": "gid://shopify/Collection/409147179222",
            "image": [
                "created_at": "2022-06-26T23:57:24+02:00",
                "alt": (Any).self,
                "width": 2000,
                "height": 1231,
                "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/collections/1651743658af793833e0a0d9cf6a9c5d.png?v=1656280644"
            ]
        ],
        [
            "id": 409147375830,
            "handle": "dr-martens",
            "title": "DR MARTENS",
            "updated_at": "2022-06-27T00:05:24+02:00",
            "body_html": "Dr Martens collection",
            "published_at": "2022-06-26T23:57:31+02:00",
            "sort_order": "best-selling",
            "template_suffix": (Any).self,
            "disjunctive": false,
            "rules": [
                [
                    "column": "title",
                    "relation": "contains",
                    "condition": "DR MARTENS"
                ]
            ],
            "published_scope": "web",
            "admin_graphql_api_id": "gid://shopify/Collection/409147375830",
            "image": [
                "created_at": "2022-06-26T23:57:31+02:00",
                "alt": (Any).self,
                "width": 220,
                "height": 125,
                "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/collections/a5f66d7e0c3e36ebbd2b7b632b2e4c47.jpg?v=1656280651"
            ]
        ]
    ]
    
    //MARK: - jsonResponseCategories
    
    let jsonResponseCategory: [[String: Any]] = [
        [
            "id": 409129779414,
            "handle": "frontpage",
            "title": "Home page",
            "updated_at": "2022-06-26T23:54:30+02:00",
            "body_html": (Any).self,
            "published_at": "2022-06-26T15:20:49+02:00",
            "sort_order": "best-selling",
            "template_suffix": (Any).self,
            "published_scope": "web",
            "admin_graphql_api_id": "gid://shopify/Collection/409129779414"
        ],
        [
            "id": 409147539670,
            "handle": "kid",
            "title": "KID",
            "updated_at": "2022-06-27T00:05:24+02:00",
            "body_html": "Collection for kids",
            "published_at": "2022-06-26T23:57:38+02:00",
            "sort_order": "best-selling",
            "template_suffix": (Any).self,
            "published_scope": "web",
            "admin_graphql_api_id": "gid://shopify/Collection/409147539670",
            "image":[
                "created_at": "2022-06-26T23:57:38+02:00",
                "alt": (Any).self,
                "width": 736,
                "height": 490,
                "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/collections/3b6a545a8f309a6085625bcadcb19712.jpg?v=1656280658"
            ]
        ],
        [
            "id": 409147474134,
            "handle": "men",
            "title": "MEN",
            "updated_at": "2022-07-17T17:35:30+02:00",
            "body_html": "Collection for men ",
            "published_at": "2022-06-26T23:57:35+02:00",
            "sort_order": "best-selling",
            "template_suffix": (Any).self,
            "published_scope": "web",
            "admin_graphql_api_id": "gid://shopify/Collection/409147474134",
            "image": [
                "created_at": "2022-06-26T23:57:35+02:00",
                "alt": (Any).self,
                "width": 480,
                "height": 200,
                "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/collections/cde37406b76337f4438c62f57be75df2.jpg?v=1656280655"
            ]
        ],
        [
            "id": 409147605206,
            "handle": "sale",
            "title": "SALE",
            "updated_at": "2022-06-26T23:57:40+02:00",
            "body_html": "On sale",
            "published_at": "2022-06-26T23:57:39+02:00",
            "sort_order": "best-selling",
            "template_suffix": (Any).self,
            "published_scope": "web",
            "admin_graphql_api_id": "gid://shopify/Collection/409147605206",
            "image": [
                "created_at": "2022-06-26T23:57:40+02:00",
                "alt": (Any).self,
                "width": 480,
                "height": 200,
                "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/collections/82c7b0b668b962bb4ffae786c8e827cd.jpg?v=1656280660"
            ]
        ],
        [
            "id": 409147506902,
            "handle": "women",
            "title": "WOMEN",
            "updated_at": "2022-06-27T00:05:24+02:00",
            "body_html": "Collection for women",
            "published_at": "2022-06-26T23:57:37+02:00",
            "sort_order": "best-selling",
            "template_suffix": (Any).self,
            "published_scope": "web",
            "admin_graphql_api_id": "gid://shopify/Collection/409147506902",
            "image": [
                "created_at": "2022-06-26T23:57:37+02:00",
                "alt": (Any).self,
                "width": 480,
                "height": 200,
                "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/collections/0711d7a9ab22e1d866c244756574349b.jpg?v=1656280657"
            ]
        ]
    ]
    
    //MARK: - jsonResponseProducts

    let jsonResponseProducts: [[String: Any]] = [
        [
        "id": 7730623709398,
        "title": "ADIDAS | CLASSIC BACKPACK",
        "body_html": "This women's backpack has a glam look, thanks to a faux-leather build with an allover fur print. The front zip pocket keeps small things within reach, while an interior divider reins in potential chaos.",
        "vendor": "ADIDAS",
        "product_type": "ACCESSORIES",
        "created_at": "2022-06-26T23:56:20+02:00",
        "handle": "adidas-classic-backpack",
        "updated_at": "2022-06-27T00:00:18+02:00",
        "published_at": "2022-06-26T23:56:20+02:00",
        "template_suffix": (Any).self,
        "status": "active",
        "published_scope": "web",
        "tags": "adidas, backpack, egnition-sample-data",
        "admin_graphql_api_id": "gid://shopify/Product/7730623709398",
        "variants": [
            [
                "id": 43130731823318,
                "product_id": 7730623709398,
                "title": "OS / black",
                "price": "70.00",
                "sku": "AD-03-black-OS",
                "position": 1,
                "inventory_policy": "deny",
                "compare_at_price": (Any).self,
                "fulfillment_service": "manual",
                "inventory_management": "shopify",
                "option1": "OS",
                "option2": "black",
                "option3": (Any).self,
                "created_at": "2022-06-26T23:56:20+02:00",
                "updated_at": "2022-06-26T23:57:25+02:00",
                "taxable": true,
                "barcode": (Any).self,
                "grams": 0,
                "image_id": (Any).self,
                "weight": 0.0,
                "weight_unit": "kg",
                "inventory_item_id": 45231424209110,
                "inventory_quantity": 6,
                "old_inventory_quantity": 6,
                "requires_shipping": true,
                "admin_graphql_api_id": "gid://shopify/ProductVariant/43130731823318"
            ]
        ],
        "options": [
            [
                "id": 9843604816086,
                "product_id": 7730623709398,
                "name": "Size",
                "position": 1,
                "values": [
                    "OS"
                ]
            ],
            [
                "id": 9843604848854,
                "product_id": 7730623709398,
                "name": "Color",
                "position": 2,
                "values": [
                    "black"
                ]
            ]
        ],
        "images": [
            [
                "id": 37836366086358,
                "product_id": 7730623709398,
                "position": 1,
                "created_at": "2022-06-26T23:56:20+02:00",
                "updated_at": "2022-06-26T23:56:20+02:00",
                "alt": (Any).self,
                "width": 635,
                "height": 560,
                "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/products/85cc58608bf138a50036bcfe86a3a362.jpg?v=1656280580",
                "variant_ids": [],
                "admin_graphql_api_id": "gid://shopify/ProductImage/37836366086358"
            ],
            [
                "id": 37836366119126,
                "product_id": 7730623709398,
                "position": 2,
                "created_at": "2022-06-26T23:56:20+02:00",
                "updated_at": "2022-06-26T23:56:20+02:00",
                "alt": (Any).self,
                "width": 635,
                "height": 560,
                "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/products/8a029d2035bfb80e473361dfc08449be.jpg?v=1656280580",
                "variant_ids": [],
                "admin_graphql_api_id": "gid://shopify/ProductImage/37836366119126"
            ],
            [
                "id": 37836366151894,
                "product_id": 7730623709398,
                "position": 3,
                "created_at": "2022-06-26T23:56:20+02:00",
                "updated_at": "2022-06-26T23:56:20+02:00",
                "alt": (Any).self,
                "width": 635,
                "height": 560,
                "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/products/ad50775123e20f3d1af2bd07046b777d.jpg?v=1656280580",
                "variant_ids": [],
                "admin_graphql_api_id": "gid://shopify/ProductImage/37836366151894"
            ]
        ],
        "image": [
            "id": 37836366086358,
            "product_id": 7730623709398,
            "position": 1,
            "created_at": "2022-06-26T23:56:20+02:00",
            "updated_at": "2022-06-26T23:56:20+02:00",
            "alt": (Any).self,
            "width": 635,
            "height": 560,
            "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/products/85cc58608bf138a50036bcfe86a3a362.jpg?v=1656280580",
            "variant_ids": [],
            "admin_graphql_api_id": "gid://shopify/ProductImage/37836366086358"
        ]
    ],
    [
        "id": 7730623774934,
        "title": "ADIDAS | CLASSIC BACKPACK | LEGEND INK MULTICOLOUR",
        "body_html": "The adidas BP Classic Cap features a pre-curved brim to keep your face shaded, while a hook-and-loop adjustable closure provides a comfortable fit. With a 3-Stripes design and reflective accents. The perfect piece to top off any outfit.",
        "vendor": "ADIDAS",
        "product_type": "ACCESSORIES",
        "created_at": "2022-06-26T23:56:22+02:00",
        "handle": "adidas-classic-backpack-legend-ink-multicolour",
        "updated_at": "2022-06-26T23:57:25+02:00",
        "published_at": "2022-06-26T23:56:22+02:00",
        "template_suffix": (Any).self,
        "status": "active",
        "published_scope": "web",
        "tags": "adidas, backpack, egnition-sample-data",
        "admin_graphql_api_id": "gid://shopify/Product/7730623774934",
        "variants": [
            [
                "id": 43130731921622,
                "product_id": 7730623774934,
                "title": "OS / blue",
                "price": "50.00",
                "sku": "AD-04\r\n-blue-OS",
                "position": 1,
                "inventory_policy": "deny",
                "compare_at_price": (Any).self,
                "fulfillment_service": "manual",
                "inventory_management": "shopify",
                "option1": "OS",
                "option2": "blue",
                "option3": (Any).self,
                "created_at": "2022-06-26T23:56:23+02:00",
                "updated_at": "2022-06-26T23:57:25+02:00",
                "taxable": true,
                "barcode": (Any).self,
                "grams": 0,
                "image_id": (Any).self,
                "weight": 0.0,
                "weight_unit": "kg",
                "inventory_item_id": 45231424307414,
                "inventory_quantity": 13,
                "old_inventory_quantity": 13,
                "requires_shipping": true,
                "admin_graphql_api_id": "gid://shopify/ProductVariant/43130731921622"
            ]
        ],
        "options": [
            [
                "id": 9843604914390,
                "product_id": 7730623774934,
                "name": "Size",
                "position": 1,
                "values": [
                    "OS"
                ]
            ],
            [
                "id": 9843604947158,
                "product_id": 7730623774934,
                "name": "Color",
                "position": 2,
                "values": [
                    "blue"
                ]
            ]
        ],
        "images": [
            [
                "id": 37836366348502,
                "product_id": 7730623774934,
                "position": 1,
                "created_at": "2022-06-26T23:56:22+02:00",
                "updated_at": "2022-06-26T23:56:22+02:00",
                "alt": (Any).self,
                "width": 635,
                "height": 560,
                "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/products/8072c8b5718306d4be25aac21836ce16.jpg?v=1656280582",
                "variant_ids": [],
                "admin_graphql_api_id": "gid://shopify/ProductImage/37836366348502"
            ],
            [
                "id": 37836366381270,
                "product_id": 7730623774934,
                "position": 2,
                "created_at": "2022-06-26T23:56:22+02:00",
                "updated_at": "2022-06-26T23:56:22+02:00",
                "alt": (Any).self,
                "width": 635,
                "height": 560,
                "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/products/32b3863554f4686d825d9da18a24cfc6.jpg?v=1656280582",
                "variant_ids": [],
                "admin_graphql_api_id": "gid://shopify/ProductImage/37836366381270"
            ],
            [
                "id": 37836366446806,
                "product_id": 7730623774934,
                "position": 3,
                "created_at": "2022-06-26T23:56:23+02:00",
                "updated_at": "2022-06-26T23:56:23+02:00",
                "alt": (Any).self,
                "width": 635,
                "height": 560,
                "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/products/044f848776141f1024eae6c610a28d12.jpg?v=1656280583",
                "variant_ids": [],
                "admin_graphql_api_id": "gid://shopify/ProductImage/37836366446806"
            ]
        ],
        "image": [
            "id": 37836366348502,
            "product_id": 7730623774934,
            "position": 1,
            "created_at": "2022-06-26T23:56:22+02:00",
            "updated_at": "2022-06-26T23:56:22+02:00",
            "alt": (Any).self,
            "width": 635,
            "height": 560,
            "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/products/8072c8b5718306d4be25aac21836ce16.jpg?v=1656280582",
            "variant_ids": [],
            "admin_graphql_api_id": "gid://shopify/ProductImage/37836366348502"
        ]
    ],
    [
        "id": 7730623381718,
        "title": "ADIDAS | KID'S STAN SMITH",
        "body_html": "The Stan Smith owned the tennis court in the '70s. Today it runs the streets with the same clean, classic style. These kids' shoes preserve the iconic look of the original, made in leather with punched 3-Stripes, heel and tongue logos and lightweight step-in cushioning.",
        "vendor": "ADIDAS",
        "product_type": "SHOES",
        "created_at": "2022-06-26T23:56:05+02:00",
        "handle": "adidas-kids-stan-smith",
        "updated_at": "2022-06-26T23:57:21+02:00",
        "published_at": "2022-06-26T23:56:05+02:00",
        "template_suffix": (Any).self,
        "status": "active",
        "published_scope": "web",
        "tags": "adidas, egnition-sample-data, kid",
        "admin_graphql_api_id": "gid://shopify/Product/7730623381718",
        "variants": [
            [
                "id": 43130731299030,
                "product_id": 7730623381718,
                "title": "1 / white",
                "price": "90.00",
                "sku": "AD-02-white-1",
                "position": 1,
                "inventory_policy": "deny",
                "compare_at_price": (Any).self,
                "fulfillment_service": "manual",
                "inventory_management": "shopify",
                "option1": "1",
                "option2": "white",
                "option3": (Any).self,
                "created_at": "2022-06-26T23:56:05+02:00",
                "updated_at": "2022-06-26T23:57:21+02:00",
                "taxable": true,
                "barcode": (Any).self,
                "grams": 0,
                "image_id": (Any).self,
                "weight": 0.0,
                "weight_unit": "kg",
                "inventory_item_id": 45231423684822,
                "inventory_quantity": 13,
                "old_inventory_quantity": 13,
                "requires_shipping": true,
                "admin_graphql_api_id": "gid://shopify/ProductVariant/43130731299030"
            ],
            [
                "id": 43130731331798,
                "product_id": 7730623381718,
                "title": "2 / white",
                "price": "90.00",
                "sku": "AD-02-white-2",
                "position": 2,
                "inventory_policy": "deny",
                "compare_at_price": (Any).self,
                "fulfillment_service": "manual",
                "inventory_management": "shopify",
                "option1": "2",
                "option2": "white",
                "option3": (Any).self,
                "created_at": "2022-06-26T23:56:05+02:00",
                "updated_at": "2022-06-26T23:57:20+02:00",
                "taxable": true,
                "barcode": (Any).self,
                "grams": 0,
                "image_id": (Any).self,
                "weight": 0.0,
                "weight_unit": "kg",
                "inventory_item_id": 45231423717590,
                "inventory_quantity": 10,
                "old_inventory_quantity": 10,
                "requires_shipping": true,
                "admin_graphql_api_id": "gid://shopify/ProductVariant/43130731331798"
            ]
        ],
        "options": [
            [
                "id": 9843604291798,
                "product_id": 7730623381718,
                "name": "Size",
                "position": 1,
                "values": [
                    "1",
                    "2"
                ]
            ],
            [
                "id": 9843604324566,
                "product_id": 7730623381718,
                "name": "Color",
                "position": 2,
                "values": [
                    "white"
                ]
            ]
        ],
        "images": [
            [
                "id": 37836364316886,
                "product_id": 7730623381718,
                "position": 1,
                "created_at": "2022-06-26T23:56:05+02:00",
                "updated_at": "2022-06-26T23:56:05+02:00",
                "alt": (Any).self,
                "width": 635,
                "height": 560,
                "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/products/7883dc186e15bf29dad696e1e989e914.jpg?v=1656280565",
                "variant_ids": [],
                "admin_graphql_api_id": "gid://shopify/ProductImage/37836364316886"
            ],
            [
                "id": 37836364349654,
                "product_id": 7730623381718,
                "position": 2,
                "created_at": "2022-06-26T23:56:05+02:00",
                "updated_at": "2022-06-26T23:56:05+02:00",
                "alt": (Any).self,
                "width": 635,
                "height": 560,
                "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/products/8cd561824439482e3cea5ba8e3a6e2f6.jpg?v=1656280565",
                "variant_ids": [],
                "admin_graphql_api_id": "gid://shopify/ProductImage/37836364349654"
            ],
            [
                "id": 37836364382422,
                "product_id": 7730623381718,
                "position": 3,
                "created_at": "2022-06-26T23:56:05+02:00",
                "updated_at": "2022-06-26T23:56:05+02:00",
                "alt": (Any).self,
                "width": 635,
                "height": 560,
                "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/products/2e1f72987692d2dcc3c02be2f194d6c5.jpg?v=1656280565",
                "variant_ids": [],
                "admin_graphql_api_id": "gid://shopify/ProductImage/37836364382422"
            ],
            [
                "id": 37836364415190,
                "product_id": 7730623381718,
                "position": 4,
                "created_at": "2022-06-26T23:56:05+02:00",
                "updated_at": "2022-06-26T23:56:05+02:00",
                "alt": (Any).self,
                "width": 635,
                "height": 560,
                "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/products/6216e82660d881e6f2b0e46dc3f8844a.jpg?v=1656280565",
                "variant_ids": [],
                "admin_graphql_api_id": "gid://shopify/ProductImage/37836364415190"
            ],
            [
                "id": 37836364447958,
                "product_id": 7730623381718,
                "position": 5,
                "created_at": "2022-06-26T23:56:05+02:00",
                "updated_at": "2022-06-26T23:56:05+02:00",
                "alt": (Any).self,
                "width": 635,
                "height": 560,
                "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/products/e5247cc373e3b61f18013282a6d9c3c0.jpg?v=1656280565",
                "variant_ids": [],
                "admin_graphql_api_id": "gid://shopify/ProductImage/37836364447958"
            ]
        ],
        "image": [
            "id": 37836364316886,
            "product_id": 7730623381718,
            "position": 1,
            "created_at": "2022-06-26T23:56:05+02:00",
            "updated_at": "2022-06-26T23:56:05+02:00",
            "alt": (Any).self,
            "width": 635,
            "height": 560,
            "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/products/7883dc186e15bf29dad696e1e989e914.jpg?v=1656280565",
            "variant_ids": [],
            "admin_graphql_api_id": "gid://shopify/ProductImage/37836364316886"
        ]
    ]]
    
}

extension NetworkMangerMock {
    
    //MARK: -  FetchBrandFromMockNetworkManager
    
    func fetchBrands(completion: @escaping ([SmartCollection]?, Error?) -> Void) {
        switch shouldReturnError {
        case true:
            completion(nil,ErrorFromNetwork.failedToFetchData )
        case false:
            if let data = try? JSONSerialization.data(withJSONObject: jsonResponseBrands, options: .fragmentsAllowed) {
                
                var arrayOfBrands = [SmartCollection]()
                
                if let arrayDecoded : SmartCollections? = convertFromJson(data: data){
                    arrayOfBrands = arrayDecoded?.smart_collections ?? []
                    
                    completion(arrayOfBrands, nil)
                }else{completion(nil, ErrorFromNetwork.failedToFetchData)}
                
            }else{completion(nil, ErrorFromNetwork.failedToFetchData)}
            
        }
        
    }
    
    //MARK: -  FetchCategoriesFromMockNetworkManager
    
    func fetchCategory(completion: @escaping ([CustomCollection]?, Error?) -> Void) {
        switch shouldReturnError {
        case true:
            completion(nil,ErrorFromNetwork.failedToFetchData )
        case false:
            if let data = try? JSONSerialization.data(withJSONObject: jsonResponseCategory, options: .fragmentsAllowed) {
                
                var arrayOfCategory = [CustomCollection]()
                
                if let arrayDecoded : CustomCollections? = convertFromJson(data: data){
                    arrayOfCategory = arrayDecoded?.custom_collections ?? []
                    
                    completion(arrayOfCategory, nil)
                }else{completion(nil, ErrorFromNetwork.failedToFetchData)}
                
            }else{completion(nil, ErrorFromNetwork.failedToFetchData)}
            
        }
    }
    
    //MARK: -  FetchProducsFromMockNetworkManager
    
    func fetchProductCategory(completion: @escaping ([ProductCategory]?, Error?) -> Void) {
        switch shouldReturnError {
        case true:
            completion(nil,ErrorFromNetwork.failedToFetchData )
        case false:
            if let data = try? JSONSerialization.data(withJSONObject: jsonResponseProducts, options: .fragmentsAllowed) {
                
                var arrayOfProducts = [ProductCategory]()
                
                if let arrayDecoded : ProductsCategory? = convertFromJson(data: data){
                    arrayOfProducts = arrayDecoded?.products ?? []
                    
                    completion(arrayOfProducts, nil)
                }else{completion(nil, ErrorFromNetwork.failedToFetchData)}
                
            }else{completion(nil, ErrorFromNetwork.failedToFetchData)}
            
        }
    }
    
}



enum ErrorFromNetwork: Error {
    case failedToFetchData
}
