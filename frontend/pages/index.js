import { ApolloProvider, gql, useQuery } from "@apollo/client"
import Link from "next/link"

import { client } from "../client"

export default function Home() {
  return <Products />
}

const Products = () => {
  const GET_PRODUCTS = gql`
    query {
      products {
        id
        name
        description
      }
    }
  `

  const { data } = useQuery(GET_PRODUCTS)
  console.log(data)
  return (
    <div>
      {data?.products.map((product) => (
        <Link href={`/product/${product.id}`}>
          <div
            style={{
              border: "1px solid #ccc",
              height: "200px",
              width: "200px",
              margin: "4px",
              padding: "12px",
            }}
          >
            {product.name}
          </div>
        </Link>
      ))}
    </div>
  )
}
