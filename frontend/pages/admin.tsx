import { gql, useMutation } from "@apollo/client"
import { useMemo, useState } from "react"

export default function Admin() {
  const [name, setName] = useState("")
  const [description, setDescription] = useState("")
  const [price, setPrice] = useState(0.0)
  const [stock, setStock] = useState(0)

  const CREATE_PRODUCT = gql`
    mutation createProduct(
      $description: String
      $name: String
      $stock: Int
      $price: Decimal
    ) {
      createProduct(
        description: $description
        name: $name
        stock: $stock
        price: $price
      ) {
        id
      }
    }
  `

  const [submitProduct] = useMutation(CREATE_PRODUCT, {
    variables: { name, description, price, stock },
  })

  return (
    <div style={{ padding: "12px" }}>
      <h2>Admin Section</h2>
      <div style={{ display: "flex", flexDirection: "column", width: 200 }}>
        <input
          onChange={(e) => setName(e.target.value)}
          placeholder="product name"
          style={{ marginBottom: "12px", padding: 8 }}
        />
        <input
          onChange={(e) => setDescription(e.target.value)}
          placeholder="description"
          style={{ marginBottom: "12px", padding: 8 }}
        />
        <input
          onChange={(e) => setPrice(Number(e.target.value))}
          placeholder="price"
          style={{ marginBottom: "12px", padding: 8 }}
          type="number"
        />
        <input
          onChange={(e) => setStock(Number(e.target.value))}
          placeholder="stock"
          style={{ marginBottom: "12px", padding: 8 }}
          type="number"
        />
      </div>

      <button onClick={submitProduct}>Submit</button>
    </div>
  )
}
