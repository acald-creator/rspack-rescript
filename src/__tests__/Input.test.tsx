import { describe, it, expect, vi } from "vitest";
import { render, screen, fireEvent } from "@testing-library/react";
import { Input } from "../components/Input/Input.bs.js";

describe("Input", () => {
	it("renders an input element", () => {
		render(<Input.make />);
		expect(screen.getByRole("textbox")).toBeInTheDocument();
	});

	it("renders with placeholder", () => {
		render(<Input.make placeholder="Enter text" />);
		expect(screen.getByPlaceholderText("Enter text")).toBeInTheDocument();
	});

	it("calls onChange when typing", () => {
		const handleChange = vi.fn();
		render(<Input.make onChange={handleChange} />);
		fireEvent.change(screen.getByRole("textbox"), {
			target: { value: "hello" },
		});
		expect(handleChange).toHaveBeenCalled();
	});

	it("renders with a controlled value", () => {
		render(<Input.make value="test value" />);
		expect(screen.getByRole("textbox")).toHaveValue("test value");
	});

	it("is disabled when disabled prop is true", () => {
		render(<Input.make disabled={true} />);
		expect(screen.getByRole("textbox")).toBeDisabled();
	});

	it("is read-only when readOnly prop is true", () => {
		render(<Input.make readOnly={true} />);
		expect(screen.getByRole("textbox")).toHaveAttribute("readonly");
	});

	it("renders with type=password", () => {
		render(<Input.make type_="password" placeholder="Password" />);
		expect(screen.getByPlaceholderText("Password")).toHaveAttribute(
			"type",
			"password",
		);
	});

	it("applies aria-label", () => {
		render(<Input.make ariaLabel="Search" />);
		expect(screen.getByLabelText("Search")).toBeInTheDocument();
	});
});
