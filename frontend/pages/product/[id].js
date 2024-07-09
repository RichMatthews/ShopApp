import { gql, useQuery } from "@apollo/client"
import { useParams } from "next/navigation"

export default function Product() {
  const params = useParams()

  const { data } = useQuery(GET_PRODUCT, {
    // skip: !params?.id,
    variables: { id: params?.id },
  })

  const onBuyNow = () => {
    // buy
  }

  const onAddToCart = () => {
    const products = JSON.parse(localStorage.getItem("shopApp::cartData"))

    const foundProduct = products.find((x) => x.id === data?.product.id)
    if (foundProduct) {
      const copy = products.map((product) => {
        if (product.id === data.product.id) {
          return {
            ...product,
            quantity: product.quantity + 1,
          }
        }
        return product
      })
      return localStorage.setItem("shopApp::cartData", JSON.stringify(copy))
    }
    const copy = [...products, { ...data.product, quantity: 1 }]
    return localStorage.setItem("shopApp::cartData", JSON.stringify(copy))
  }

  return (
    <div style={{ padding: "12px" }}>
      <h2>{data?.product?.name}</h2>
      <div>Description: {data?.product?.description}</div>
      <div>£{data?.product?.price}</div>

      <div
        style={{
          border: "1px solid black",
          borderRadius: "4px",
          cursor: "pointer",
          padding: "4px",
          marginTop: "12px",
          width: "100px",
        }}
        onClick={onAddToCart}
      >
        Add to cart
      </div>

      <div
        style={{
          border: "1px solid black",
          borderRadius: "4px",
          cursor: "pointer",
          padding: "4px",
          marginTop: "12px",
          width: "100px",
        }}
        onClick={onBuyNow}
      >
        Buy now
      </div>

      <h2>Reviews</h2>
      {data?.product?.reviews?.map((review) => (
        <div>
          <h3>{review.rating} stars</h3>
          <span>{review.comment}</span>
        </div>
      ))}
    </div>
  )
}

const GET_PRODUCT = gql`
  query getProduct($id: UUID!) {
    product(id: $id) {
      id
      name
      price
      description
      reviews {
        id
        rating
        comment
      }
    }
  }
`
